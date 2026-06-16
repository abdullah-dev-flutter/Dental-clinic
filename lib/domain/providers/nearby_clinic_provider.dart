import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase_client.dart';
import '../../data/models/nearby_clinic_model.dart';
import '../../data/repositories/nearby_clinic_repository.dart';

final nearbyClinicRepositoryProvider = Provider<NearbyClinicRepository>((ref) {
  return NearbyClinicRepository(ref.read(supabaseClientProvider));
});

final nearbyClinicsProvider = FutureProvider<List<NearbyClinicModel>>((
  ref,
) async {
  return ref.read(nearbyClinicRepositoryProvider).fetchNearbyClinics();
});

final clinicRadiusProvider = StateProvider<double>((ref) => 5);

final nearbyClinicsWithRadiusProvider =
    FutureProvider.family<List<NearbyClinicModel>, double>((ref, radiusKm) {
      return ref
          .read(nearbyClinicRepositoryProvider)
          .fetchNearbyClinics(radiusKm: radiusKm);
    });
