import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/dental_service_model.dart';
import '../models/clinic_model.dart';

class ServiceRepository {
  final SupabaseClient _client;
  ServiceRepository(this._client);

  Future<List<DentalServiceModel>> fetchActiveServices() async {
    return safeCall(() async {
      final response = await _client
          .from('dental_services')
          .select()
          .eq('is_active', true)
          .order('name');
      return response.map((e) => DentalServiceModel.fromJson(e)).toList();
    });
  }

  Future<List<ClinicModel>> fetchClinics() async {
    return safeCall(() async {
      final response = await _client
          .from('clinics')
          .select()
          .order('name');
      return response.map((e) => ClinicModel.fromJson(e)).toList();
    });
  }
}

