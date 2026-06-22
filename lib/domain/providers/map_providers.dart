import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/map_clinic_entity.dart';
import '../../data/models/nearby_clinic_model.dart';
import '../../data/repositories/osm_repository.dart';
import 'location_provider.dart';
import 'nearby_clinic_provider.dart';

class MapFilterState {
  final String searchQuery;
  final bool openNow;
  final bool partnerOnly;
  final bool osmOnly;
  final double radiusLimit;

  MapFilterState({
    this.searchQuery = '',
    this.openNow = false,
    this.partnerOnly = false,
    this.osmOnly = false,
    this.radiusLimit = 20,
  });

  MapFilterState copyWith({
    String? searchQuery,
    bool? openNow,
    bool? partnerOnly,
    bool? osmOnly,
    double? radiusLimit,
  }) {
    return MapFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      openNow: openNow ?? this.openNow,
      partnerOnly: partnerOnly ?? this.partnerOnly,
      osmOnly: osmOnly ?? this.osmOnly,
      radiusLimit: radiusLimit ?? this.radiusLimit,
    );
  }
}

class MapFilterNotifier extends StateNotifier<MapFilterState> {
  MapFilterNotifier() : super(MapFilterState());

  void updateSearch(String query) => state = state.copyWith(searchQuery: query);
  void toggleOpenNow() => state = state.copyWith(openNow: !state.openNow);

  void togglePartnerOnly() {
    state = state.copyWith(partnerOnly: !state.partnerOnly, osmOnly: false);
  }

  void toggleOsmOnly() {
    state = state.copyWith(osmOnly: !state.osmOnly, partnerOnly: false);
  }

  void setRadius(double radius) => state = state.copyWith(radiusLimit: radius);
}

final mapFilterProvider =
    StateNotifierProvider<MapFilterNotifier, MapFilterState>((ref) {
  return MapFilterNotifier();
});

final osmRepositoryProvider = Provider<OsmRepository>((ref) {
  return OsmRepository();
});

final allMapClinicsProvider = FutureProvider<List<MapClinicEntity>>((ref) async {
  final position = await ref.watch(locationProvider.future);
  final userLatitude = position.latitude;
  final userLongitude = position.longitude;
  final userLocation = LatLng(userLatitude, userLongitude);

  var supabaseClinics = <NearbyClinicModel>[];
  try {
    final supabaseRepo = ref.read(nearbyClinicRepositoryProvider);
    supabaseClinics = await supabaseRepo.fetchNearbyClinics(radiusKm: 20);
  } catch (_) {}

  var osmClinics = <MapClinicEntity>[];
  try {
    final osmRepository = ref.read(osmRepositoryProvider);
    osmClinics = await osmRepository.fetchNearbyDentists(userLocation, 5);
  } catch (_) {}

  if (supabaseClinics.isEmpty && osmClinics.isEmpty) {
    throw Exception('Failed to load any clinics. Please check your connection.');
  }

  final merged = <MapClinicEntity>[];
  for (final clinic in supabaseClinics) {
    merged.add(MapClinicEntity(
      id: clinic.id,
      name: clinic.name,
      address: clinic.address,
      latitude: clinic.lat,
      longitude: clinic.lng,
      source: ClinicSource.partner,
      distanceKm: clinic.distanceKm,
      phone: clinic.phone,
      website: clinic.website,
      openingHours: clinic.openingHours,
      isVerified: clinic.isVerified,
    ));
  }

  for (final osm in osmClinics) {
    final distance = Geolocator.distanceBetween(
          userLatitude,
          userLongitude,
          osm.latitude,
          osm.longitude,
        ) /
        1000;
    merged.add(osm.copyWithDistance(distance));
  }

  final uniqueClinics = <MapClinicEntity>[];
  for (final clinic in merged) {
    var isDuplicate = false;
    final normalizedName = _normalize(clinic.name);

    for (final existing in List<MapClinicEntity>.from(uniqueClinics)) {
      final existingName = _normalize(existing.name);
      final distanceBetween = Geolocator.distanceBetween(
        clinic.latitude,
        clinic.longitude,
        existing.latitude,
        existing.longitude,
      );

      if (distanceBetween < 50 &&
          (normalizedName.contains(existingName) || existingName.contains(normalizedName))) {
        if (clinic.source == ClinicSource.partner && existing.source == ClinicSource.osm) {
          uniqueClinics.remove(existing);
          uniqueClinics.add(clinic);
        }
        isDuplicate = true;
        break;
      }
    }

    if (!isDuplicate) uniqueClinics.add(clinic);
  }

  uniqueClinics.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
  return uniqueClinics;
});

final filteredMapClinicsProvider = Provider<AsyncValue<List<MapClinicEntity>>>((ref) {
  final allClinics = ref.watch(allMapClinicsProvider);
  final filter = ref.watch(mapFilterProvider);

  return allClinics.whenData((clinics) {
    return clinics.where((clinic) {
      if (clinic.distanceKm > filter.radiusLimit) return false;
      if (filter.partnerOnly && clinic.source != ClinicSource.partner) return false;
      if (filter.osmOnly && clinic.source != ClinicSource.osm) return false;

      if (filter.searchQuery.isNotEmpty) {
        final query = filter.searchQuery.toLowerCase();
        return clinic.name.toLowerCase().contains(query) ||
            clinic.address.toLowerCase().contains(query);
      }

      return true;
    }).toList();
  });
});

final selectedClinicProvider = StateProvider<MapClinicEntity?>((ref) => null);

String _normalize(String value) {
  return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
}
