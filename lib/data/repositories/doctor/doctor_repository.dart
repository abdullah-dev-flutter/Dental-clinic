import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/exceptions.dart';
import '../../models/doctor/doctor_model.dart';
import '../../models/upcoming_appointment_model.dart';

class DoctorRepository {
  final SupabaseClient _client;
  DoctorRepository(this._client);

  Future<DoctorModel?> fetchDoctorProfile(String userId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctors')
          .select('''
            *,
            clinic:clinics(
              name,
              address,
              lat,
              lng
            )
          ''')
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return null;
      return DoctorModel.fromJson(_flattenClinic(response));
    });
  }

  Future<DoctorModel?> fetchDoctorProfileById(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctors')
          .select('''
            *,
            clinic:clinics(
              name,
              address,
              lat,
              lng
            )
          ''')
          .eq('id', doctorId)
          .maybeSingle();

      if (response == null) return null;
      return DoctorModel.fromJson(_flattenClinic(response));
    });
  }

  Future<List<Map<String, dynamic>>> getDoctorPatients(String doctorId) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_doctor_patients',
        params: {'p_doctor_id': doctorId},
      );
      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<List<UpcomingAppointmentModel>> getAppointments({
    required String doctorId,
    String? status,
    String? date,
  }) async {
    return safeCall(() async {
      var query = _client
          .from('upcoming_appointments_view')
          .select()
          .eq('doctor_id', doctorId);

      if (status != null && status.isNotEmpty) query = query.eq('status', status);
      if (date != null && date.isNotEmpty) query = query.eq('appointment_date', date);

      final response = await query
          .order('appointment_date', ascending: false)
          .order('start_time', ascending: true);
      return response.map((e) => UpcomingAppointmentModel.fromJson(e)).toList();
    });
  }

  Future<UpcomingAppointmentModel?> getAppointmentById(String appointmentId) async {
    return safeCall(() async {
      final response = await _client
          .from('upcoming_appointments_view')
          .select()
          .eq('id', appointmentId)
          .maybeSingle();

      if (response == null) return null;
      return UpcomingAppointmentModel.fromJson(response);
    });
  }

  Future<List<Map<String, dynamic>>> getPayments(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('payments')
          .select('''
            *,
            patient:profiles(full_name),
            appointment:appointments(
              appointment_date,
              start_time,
              patient_name
            )
          ''')
          .eq('doctor_id', doctorId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    return safeCall(() async {
      await _client
          .from('appointments')
          .update({'status': status})
          .eq('id', appointmentId);
    });
  }

  Future<List<Map<String, dynamic>>> getSchedule(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctor_schedules')
          .select()
          .eq('doctor_id', doctorId)
          .order('day_of_week');

      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<List<Map<String, dynamic>>> getLeaves(String doctorId) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return safeCall(() async {
      final response = await _client
          .from('doctor_leaves')
          .select()
          .eq('doctor_id', doctorId)
          .gte('leave_date', today)
          .order('leave_date');

      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<Map<String, dynamic>> getDashboardStats(String doctorId) async {
    return getTodayStats(doctorId);
  }

  Future<Map<String, dynamic>> getTodayStats(String doctorId) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_today_stats',
        params: {'p_doctor_id': doctorId},
      );

      final row = response is List && response.isNotEmpty
          ? response.first
          : response;
      if (row is! Map) {
        return {
          'totalAppointments': 0,
          'completedAppointments': 0,
          'pendingAppointments': 0,
          'todayEarnings': 0.0,
        };
      }

      final data = Map<String, dynamic>.from(row);
      return {
        'totalAppointments': (data['total_today'] as num?)?.toInt() ?? 0,
        'completedAppointments': (data['completed_today'] as num?)?.toInt() ?? 0,
        'pendingAppointments': (data['pending_today'] as num?)?.toInt() ?? 0,
        'todayEarnings': (data['today_earnings'] as num?)?.toDouble() ?? 0.0,
      };
    });
  }

  Future<List<Map<String, dynamic>>> getWeeklyAppointments(String doctorId) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_weekly_appointments',
        params: {'p_doctor_id': doctorId},
      );
      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<List<Map<String, dynamic>>> getMonthlyEarnings(String doctorId) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_monthly_earnings',
        params: {'p_doctor_id': doctorId},
      );
      return List<Map<String, dynamic>>.from(response as List);
    });
  }

  Future<String> createDoctorProfile(DoctorModel doctor) async {
    return safeCall(() async {
      final data = doctor.toJson()
        ..remove('id')
        ..remove('clinic_name')
        ..remove('clinic_address')
        ..remove('clinic_lat')
        ..remove('clinic_lng');

      final response = await _client.from('doctors').insert(data).select('id').single();
      return response['id'] as String;
    });
  }

  Future<void> uploadVerificationDocuments({
    required String doctorId,
    required String pmdcUrl,
    required String degreeUrl,
    required String cnicUrl,
  }) async {
    return safeCall(() async {
      await _client.from('doctor_verifications').insert({
        'doctor_id': doctorId,
        'pmdc_license_url': pmdcUrl,
        'degree_url': degreeUrl,
        'cnic_url': cnicUrl,
      });
    });
  }

  Map<String, dynamic> _flattenClinic(Map<String, dynamic> response) {
    final map = Map<String, dynamic>.from(response);
    final clinic = map['clinic'];
    if (clinic is Map) {
      map['clinic_name'] ??= clinic['name'];
      map['clinic_address'] ??= clinic['address'];
      map['clinic_lat'] ??= clinic['lat'];
      map['clinic_lng'] ??= clinic['lng'];
    }
    map.remove('clinic');
    return map;
  }

}
