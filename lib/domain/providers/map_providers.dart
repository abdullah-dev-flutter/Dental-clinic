import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/map_clinic_entity.dart';
import '../../data/models/nearby_clinic_model.dart';
import '../../data/repositories/osm_repository.dart';
import 'location_provider.dart';
import 'nearby_clinic_provider.dart';

// --- Filter State ---

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
    this.radiusLimit = 20.0,
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

final mapFilterProvider = StateNotifierProvider<MapFilterNotifier, MapFilterState>((ref) {
  return MapFilterNotifier();
});

// --- Repository Providers ---

final osmRepositoryProvider = Provider<OsmRepository>((ref) {
  return OsmRepository();
});

// --- Data Fetching & Merging ---

final allMapClinicsProvider = FutureProvider<List<MapClinicEntity>>((ref) async {
  final position = await ref.watch(locationProvider.future);
  final userLat = position.latitude;
  final userLng = position.longitude;
  final userLocation = LatLng(userLat, userLng);

  // 1. Fetch Supabase Clinics (20km radius as requested)
  List<NearbyClinicModel> supabaseClinics = [];
  try {
    final supabaseRepo = ref.read(nearbyClinicRepositoryProvider);
    supabaseClinics = await supabaseRepo.fetchNearbyClinics(radiusKm: 20.0);
  } catch (e) {
    // Silent fail
  }

  // 2. Fetch OSM Clinics (5km radius as per task)
  List<MapClinicEntity> osmClinics = [];
  try {
    final osmRepository = ref.read(osmRepositoryProvider);
    osmClinics = await osmRepository.fetchNearbyDentists(userLocation, 5.0);
  } catch (e) {
    // Silent fail
  }

  if (supabaseClinics.isEmpty && osmClinics.isEmpty) {
    throw Exception('Failed to load any clinics. Please check your connection.');
  }

  List<MapClinicEntity> merged = [];

  // Add Supabase clinics (Source: Partner)
  for (final c in supabaseClinics) {
    if (c.latitude != null && c.longitude != null) {
      merged.add(MapClinicEntity(
        id: c.id,
        name: c.name,
        address: c.address,
        latitude: c.latitude!,
        longitude: c.longitude!,
        source: ClinicSource.partner,
        distanceKm: c.distanceKm,
        phone: c.phone,
        website: c.website,
        openingHours: c.openingHours,
        isVerified: c.isVerified,
      ));
    }
  }

  // Add OSM clinics with precise distance calculation
  for (final osm in osmClinics) {
    final dist = Geolocator.distanceBetween(
      userLat, userLng, osm.latitude, osm.longitude
    ) / 1000;
    merged.add(osm.copyWithDistance(dist));
  }

  // Deep deduplication: prioritize Partner (Supabase) version if location and name are very similar
  final uniqueClinics = <MapClinicEntity>[];
  
  for (final clinic in merged) {
    bool isDuplicate = false;
    
    // Normalize name for fuzzy matching
    final normalizedName = clinic.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    
    for (final existing in uniqueClinics) {
      final existingNormalizedName = existing.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      
      // Calculate distance between this clinic and an already added one
      final distBetween = Geolocator.distanceBetween(
        clinic.latitude, clinic.longitude, 
        existing.latitude, existing.longitude
      );

      // If location is within 50 meters AND names are very similar, consider it a duplicate
      if (distBetween < 50 && (normalizedName.contains(existingNormalizedName) || existingNormalizedName.contains(normalizedName))) {
        // If the new one is Partner but existing is OSM, replace it (Partner priority)
        if (clinic.source == ClinicSource.partner && existing.source == ClinicSource.osm) {
          uniqueClinics.remove(existing);
          uniqueClinics.add(clinic);
        }
        isDuplicate = true;
        break;
      }
    }
    
    if (!isDuplicate) {
      uniqueClinics.add(clinic);
    }
  }

  // Sort by closest
  uniqueClinics.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

  return uniqueClinics;
});

// --- Filtered Results ---

final filteredMapClinicsProvider = Provider<AsyncValue<List<MapClinicEntity>>>((ref) {
  final allClinics = ref.watch(allMapClinicsProvider);
  final filter = ref.watch(mapFilterProvider);

  return allClinics.whenData((clinics) {
    return clinics.where((c) {
      // 1. Distance filter
      if (c.distanceKm > filter.radiusLimit) return false;

      // 2. Source filter
      if (filter.partnerOnly && c.source != ClinicSource.partner) return false;
      if (filter.osmOnly && c.source != ClinicSource.osm) return false;

      // 3. Search query (matches name or address)
      if (filter.searchQuery.isNotEmpty) {
        final query = filter.searchQuery.toLowerCase();
        if (!c.name.toLowerCase().contains(query) && 
            !c.address.toLowerCase().contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();
  });
});

// Selected clinic for detail screen (avoids passing objects through route state)
final selectedClinicProvider = StateProvider<MapClinicEntity?>((ref) => null);
