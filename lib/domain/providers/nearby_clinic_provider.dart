import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase_client.dart';
import '../../data/models/map_clinic_entity.dart';
import '../../data/repositories/nearby_clinic_repository.dart';
import 'map_providers.dart';

final nearbyClinicRepositoryProvider = Provider<NearbyClinicRepository>((ref) {
  return NearbyClinicRepository(ref.read(supabaseClientProvider));
});

/// Returns a unified list of clinics from both Supabase and OpenStreetMap.
/// This uses the allMapClinicsProvider logic which handles merging and deduplication.
final nearbyClinicsProvider = FutureProvider<List<MapClinicEntity>>((
  ref,
) async {
  return ref.watch(allMapClinicsProvider.future);
});

final clinicRadiusProvider = StateProvider<double>((ref) => 5);

final nearbyClinicsWithRadiusProvider =
    FutureProvider.family<List<MapClinicEntity>, double>((ref, radiusKm) {
      // For filtered/radius-specific lists, we can reuse filteredMapClinicsProvider
      // or create a custom one if needed. For now, returning all for simplicity
      // as the map providers handle radii.
      return ref.watch(allMapClinicsProvider.future);
    });
