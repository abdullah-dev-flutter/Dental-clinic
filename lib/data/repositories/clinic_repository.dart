import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/clinic_model.dart';

class ClinicRepository {
  final SupabaseClient _client;
  ClinicRepository(this._client);

  Future<List<ClinicModel>> getNearbyClinics(
    double lat,
    double lng, {
    int radiusKm = 10,
  }) async {
    final response = await _client.rpc(
      'get_nearby_clinics',
      params: {
        'user_lat': lat,
        'user_lng': lng,
        'radius_km': radiusKm,
      },
    );

    return (response as List)
        .map((e) => ClinicModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<List<ClinicModel>> getClinicsNearPatient(
    double lat,
    double lng, {
    int radiusKm = 5,
  }) async {
    final response = await _client.rpc(
      'get_clinics_near_patient',
      params: {
        'patient_lat': lat,
        'patient_lng': lng,
        'radius_km': radiusKm,
      },
    );

    return (response as List).map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return ClinicModel.fromJson({
        'id': map['clinic_id'],
        'name': map['clinic_name'],
        'address': map['clinic_address'],
        'lat': map['lat'],
        'lng': map['lng'],
        'distance_km': map['distance_km'],
        'total_doctors': map['total_doctors'],
        'avg_rating': map['avg_rating'],
        'min_fee': map['min_fee'],
      });
    }).toList();
  }

  Future<String> registerDoctorClinic({
    required String doctorId,
    required String clinicName,
    required String clinicAddress,
    required double lat,
    required double lng,
    String? existingClinicId,
  }) async {
    final result = await _client.rpc(
      'register_doctor_clinic',
      params: {
        'p_doctor_id': doctorId,
        'p_clinic_name': clinicName,
        'p_clinic_address': clinicAddress,
        'p_lat': lat,
        'p_lng': lng,
        'p_existing_clinic_id': existingClinicId,
      },
    );

    return result.toString();
  }

  Future<ClinicModel?> getClinicById(String clinicId) async {
    final response = await _client
        .from('clinics')
        .select()
        .eq('id', clinicId)
        .maybeSingle();

    if (response == null) return null;
    return ClinicModel.fromJson(response);
  }

  Future<List<ClinicModel>> searchClinicsByName(String query) async {
    final response = await _client
        .from('clinics')
        .select()
        .ilike('name', '%$query%')
        .limit(10);

    return (response as List)
        .map((e) => ClinicModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
