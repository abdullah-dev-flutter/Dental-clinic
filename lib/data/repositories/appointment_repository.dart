import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/upcoming_appointment_model.dart';
import '../models/appointment_model.dart';
import '../models/time_slot.dart';

class AppointmentRepository {
  final SupabaseClient _client;
  AppointmentRepository(this._client);

  Future<List<UpcomingAppointmentModel>> fetchUpcomingAppointments(String patientPhone) async {
    return safeCall(() async {
      final response = await _client
          .from('upcoming_appointments_view')
          .select()
          .eq('patient_phone', patientPhone)
          .order('appointment_date')
          .limit(3);
      return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
    });
  }

  Future<List<UpcomingAppointmentModel>> fetchAppointmentsByStatus({
    required String patientPhone,
    required String status,
  }) async {
    return safeCall(() async {
      if (status == 'upcoming') {
        final response = await _client
            .from('upcoming_appointments_view')
            .select()
            .eq('patient_phone', patientPhone)
            .order('appointment_date');
        return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
      } else {
        final response = await _client
            .from('appointments')
            .select('*')
            .eq('patient_phone', patientPhone)
            .eq('status', status)
            .order('appointment_date', ascending: false);
        return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
      }
    });
  }

  Future<List<TimeSlot>> fetchAvailableSlots({
    required String clinicId,
    required DateTime date,
  }) async {
    return safeCall(() async {
      // 1. Define static slots: 9 AM to 3 PM every 30 mins
      final List<TimeSlot> staticSlots = [];
      final dateStr = date.toIso8601String().split('T')[0];

      // Start at 09:00, End at 15:00
      for (int hour = 9; hour < 15; hour++) {
        for (int min = 0; min < 60; min += 30) {
          final startStr = '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}';
          
          final endDt = DateTime(2000, 1, 1, hour, min).add(const Duration(minutes: 30));
          final endStr = '${endDt.hour.toString().padLeft(2, '0')}:${endDt.minute.toString().padLeft(2, '0')}';
          
          staticSlots.add(TimeSlot(
            start: startStr,
            end: endStr,
            available: true,
          ));
        }
      }

      // 2. Fetch already booked slots from DB
      final bookedResponse = await _client
          .from('appointments')
          .select('start_time')
          .eq('clinic_id', clinicId)
          .eq('appointment_date', dateStr)
          .neq('status', 'cancelled');

      final bookedStartTimes = (bookedResponse as List)
          .map((e) => e['start_time'] as String)
          .toList();

      // 3. Mark booked slots as unavailable
      return staticSlots.map((slot) {
        if (bookedStartTimes.contains(slot.start)) {
          return slot.copyWith(available: false);
        }
        return slot;
      }).toList();
    });
  }

  Future<AppointmentModel> bookAppointment({
    required String patientId,
    String? doctorId,
    required String clinicId,
    required String clinicName,
    required String serviceName,
    required String patientName,
    required String patientPhone,
    required DateTime appointmentDate,
    required String startTime,
    required String endTime,
    required double amount,
    required String paymentMethod,
    required List<Map<String, dynamic>> servicesSelected,
    String? notes,
  }) async {
    return safeCall(() async {
      final apptResponse = await _client
          .from('appointments')
          .insert({
            'patient_id': patientId,
            if (doctorId != null) 'doctor_id': doctorId,
            'clinic_id': clinicId,
            'clinic_name': clinicName,
            'service': serviceName,
            'patient_name': patientName,
            'patient_phone': patientPhone,
            'appointment_date': appointmentDate.toIso8601String().split('T')[0],
            'start_time': startTime,
            'end_time': endTime,
            'status': 'upcoming',
            'cost': amount,
            'payment_method': paymentMethod,
            'services_selected': servicesSelected,
            'notes': notes,
          })
          .select()
          .single();

      return AppointmentModel.fromJson(apptResponse);
    });
  }

  Future<void> cancelAppointment(String appointmentId) async {
    return safeCall(() async {
      await _client
          .from('appointments')
          .update({'status': 'cancelled'})
          .eq('id', appointmentId)
          .eq('status', 'upcoming');
    });
  }
}
