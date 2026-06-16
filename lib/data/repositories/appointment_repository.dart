import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/upcoming_appointment_model.dart';
import '../models/appointment_model.dart';
import '../models/time_slot.dart';

class AppointmentRepository {
  final SupabaseClient _client;
  AppointmentRepository(this._client);

  Future<List<UpcomingAppointmentModel>> fetchUpcomingAppointments(String patientId) async {
    return safeCall(() async {
      final response = await _client
          .from('upcoming_appointments_view')
          .select()
          .eq('patient_id', patientId)
          .order('appointment_date')
          .limit(3);
      return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
    });
  }

  Future<List<UpcomingAppointmentModel>> fetchAppointmentsByStatus({
    required String patientId,
    required String status,
  }) async {
    return safeCall(() async {
      if (status == 'upcoming') {
        final response = await _client
            .from('upcoming_appointments_view')
            .select()
            .eq('patient_id', patientId)
            .order('appointment_date');
        return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
      } else {
        final response = await _client
            .from('appointments')
            .select('*, doctors(*), dental_services(*)')
            .eq('patient_id', patientId)
            .eq('status', status)
            .order('appointment_date', ascending: false);
        return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
      }
    });
  }

  Future<List<TimeSlot>> fetchAvailableSlots({
    required String doctorId,
    required DateTime date,
    required int durationMinutes,
  }) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_available_slots',
        params: {
          'p_doctor_id': doctorId,
          'p_date': date.toIso8601String().split('T')[0],
          'p_duration': durationMinutes,
        },
      );
      return (response as List)
          .map((e) => TimeSlot(
                start: e['slot_start'] as String,
                end: e['slot_end'] as String,
              ))
          .toList();
    });
  }

  Future<AppointmentModel> bookAppointment({
    required String patientId,
    required String doctorId,
    required String serviceId,
    required String clinicId,
    required DateTime appointmentDate,
    required String startTime,
    required String endTime,
    required String paymentMethod,
    required double amount,
    String? notes,
  }) async {
    return safeCall(() async {
      // 1. Insert appointment
      final apptResponse = await _client
          .from('appointments')
          .insert({
            'patient_id': patientId,
            'doctor_id': doctorId,
            'service_id': serviceId,
            'clinic_id': clinicId,
            'appointment_date': appointmentDate.toIso8601String().split('T')[0],
            'start_time': startTime,
            'end_time': endTime,
            'status': 'upcoming',
            'notes': notes,
          })
          .select()
          .single();

      final appointment = AppointmentModel.fromJson(apptResponse);

      // 2. Insert payment record
      await _client.from('payments').insert({
        'appointment_id': appointment.id,
        'patient_id': patientId,
        'amount': amount,
        'method': paymentMethod,
        'status': 'pending',
      });

      return appointment;
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
