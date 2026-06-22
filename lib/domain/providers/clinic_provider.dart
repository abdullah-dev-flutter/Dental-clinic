import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../providers/repository_providers.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/clinic_location_model.dart';

// Selected clinic location for registration flow
final selectedClinicProvider =
    StateProvider<ClinicLocationModel?>((ref) => null);

// Nearby clinics for map (10km default)
final nearbyClinicsProvider =
    FutureProvider.family<List<ClinicModel>, LatLng>(
  (ref, position) async {
    final repo = ref.read(clinicRepositoryProvider);
    return repo.getNearbyClinics(
      position.latitude,
      position.longitude,
      radiusKm: 10,
    );
  },
);

// Patient nearby clinics (5km default)
final patientNearbyClinicsProvider =
    FutureProvider.family<List<ClinicModel>, LatLng>(
  (ref, position) async {
    final repo = ref.read(clinicRepositoryProvider);
    return repo.getClinicsNearPatient(
      position.latitude,
      position.longitude,
      radiusKm: 5,
    );
  },
);

// Search clinics by name via Nominatim
final searchClinicsProvider =
    FutureProvider.family<List<ClinicModel>, String>(
  (ref, query) async {
    if (query.isEmpty) return [];

    final repo = ref.read(clinicRepositoryProvider);
    return repo.searchClinicsByName(query);
  },
);
