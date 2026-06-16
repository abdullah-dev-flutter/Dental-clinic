import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/exceptions.dart';
import '../models/nearby_clinic_model.dart';

class NearbyClinicRepository {
  final SupabaseClient _client;

  NearbyClinicRepository(this._client);

  Future<List<NearbyClinicModel>> fetchNearbyClinics({
    double radiusKm = 5,
  }) async {
    final position = await _getCurrentLocation();
    return getNearbyClinics(
      latitude: position.latitude,
      longitude: position.longitude,
      radiusKm: radiusKm,
    );
  }

  Future<List<NearbyClinicModel>> getNearbyClinics({
    required double latitude,
    required double longitude,
    double radiusKm = 5,
  }) {
    return safeCall(() async {
      final response = await _client.rpc(
        'get_nearby_clinics',
        params: {
          'user_lat': latitude,
          'user_lng': longitude,
          'radius_km': radiusKm,
        },
      );

      final rows = response as List<dynamic>;
      final clinics = rows.map((row) {
        final map = Map<String, dynamic>.from(row as Map);
        return NearbyClinicModel.fromJson(map);
      }).toList();

      clinics.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      return clinics;
    });
  }

  Future<Position> _getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw AppException.unknown('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw AppException.unknown('Location permission denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw AppException.unknown('Location permission permanently denied.');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
