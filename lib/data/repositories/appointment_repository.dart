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
    String? doctorId,
    required String clinicId,
    required DateTime date,
  }) async {
    return safeCall(() async {
      String? actualDoctorId = doctorId;

      // If no doctor was explicitly selected, find one that works at this clinic
      if (actualDoctorId == null) {
        final docResponse = await _client
            .from('doctor_availability')
            .select('doctor_id')
            .eq('clinic_id', clinicId)
            .limit(1)
            .maybeSingle();

        if (docResponse != null) {
          actualDoctorId = docResponse['doctor_id'] as String;
        } else {
          // Fallback: just get any doctor to satisfy the RPC
          final anyDoc = await _client
              .from('doctors')
              .select('id')
              .limit(1)
              .maybeSingle();
          if (anyDoc != null) {
            actualDoctorId = anyDoc['id'] as String;
          }
        }
      }

      // If absolutely no doctor exists in DB, return empty or mock
      if (actualDoctorId == null) return [];

      final response = await _client.rpc(
        'get_available_slots',
        params: {
          'p_doctor_id': actualDoctorId,
          'p_clinic_id': clinicId,
          'p_date': date.toIso8601String().split('T')[0],
        },
      );
      return (response as List).map((e) {
        final slot = TimeSlot.fromJson(e);
        return slot;
      }).toList();
    });
  }

  Future<AppointmentModel> bookAppointment({
    required String patientId,
    required String doctorId,
    required String serviceId,
    required String clinicId,
    required DateTime appointmentDate,
    required String startTime,
    required double amount,
    String? notes,
  }) async {
    return safeCall(() async {
      // Use the RPC if available, or direct insert
      final apptResponse = await _client
          .from('appointments')
          .insert({
            'patient_id': patientId,
            'doctor_id': doctorId,
            'service_id': serviceId,
            'clinic_id': clinicId,
            'appointment_date': appointmentDate.toIso8601String().split('T')[0],
            'appointment_time': startTime,
            'status': 'pending',
            'cost': amount,
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
