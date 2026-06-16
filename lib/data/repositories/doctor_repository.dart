import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/doctor_model.dart';
import '../models/doctor_with_services_model.dart';
import '../models/dental_service_model.dart';
import '../models/review_model.dart';
import '../models/doctor_schedule_model.dart';

class DoctorRepository {
  final SupabaseClient _client;
  DoctorRepository(this._client);

  Future<List<DoctorModel>> fetchAllDoctors({String? specialty}) async {
    return safeCall(() async {
      var query = _client
          .from('doctors')
          .select()
          .eq('is_active', true);

      if (specialty != null && specialty != 'all') {
        query = query.eq('specialty', specialty);
      }

      final response = await query.order('rating', ascending: false);
      return response.map((e) => DoctorModel.fromJson(e)).toList();
    });
  }

  Future<List<DoctorWithServicesModel>> fetchDoctorsWithServices({
    String? specialty,
    String? searchQuery,
  }) async {
    return safeCall(() async {
      var query = _client
          .from('doctors_with_services')
          .select();

      if (specialty != null && specialty != 'all') {
        query = query.eq('specialty', specialty);
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('full_name', '%$searchQuery%');
      }

      final response = await query.order('rating', ascending: false);
      return response.map((e) => DoctorWithServicesModel.fromJson(e)).toList();
    });
  }

  Future<DoctorWithServicesModel> fetchDoctorById(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctors_with_services')
          .select()
          .eq('id', doctorId)
          .single();
      return DoctorWithServicesModel.fromJson(response);
    });
  }

  Future<List<DentalServiceModel>> fetchDoctorServices(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctor_services')
          .select('service_id, dental_services(*)')
          .eq('doctor_id', doctorId);
      return (response as List)
          .map((e) => DentalServiceModel.fromJson(e['dental_services']))
          .toList();
    });
  }

  Future<List<ReviewModel>> fetchDoctorReviews(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('reviews')
          .select('*, profiles(full_name, avatar_url)')
          .eq('doctor_id', doctorId)
          .order('created_at', ascending: false)
          .limit(20);
      return (response as List).map((e) => ReviewModel.fromJson(e)).toList();
    });
  }

  Future<List<DoctorScheduleModel>> fetchDoctorSchedule(String doctorId) async {
    return safeCall(() async {
      final response = await _client
          .from('doctor_schedules')
          .select()
          .eq('doctor_id', doctorId)
          .eq('is_available', true);
      return (response as List).map((e) => DoctorScheduleModel.fromJson(e)).toList();
    });
  }
}
