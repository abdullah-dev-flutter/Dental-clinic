enum ClinicSource { partner, osm }

class MapClinicEntity {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final ClinicSource source;
  final double distanceKm;
  final String? phone;
  final String? website;
  final String? openingHours;
  final bool isVerified;

  MapClinicEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.source,
    required this.distanceKm,
    this.phone,
    this.website,
    this.openingHours,
    this.isVerified = false,
  });

  String get distanceText {
    if (distanceKm < 1) return '${(distanceKm * 1000).round()} m';
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  MapClinicEntity copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    ClinicSource? source,
    double? distanceKm,
    String? phone,
    String? website,
    String? openingHours,
    bool? isVerified,
  }) {
    return MapClinicEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      source: source ?? this.source,
      distanceKm: distanceKm ?? this.distanceKm,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      openingHours: openingHours ?? this.openingHours,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  MapClinicEntity copyWithDistance(double dist) {
    return MapClinicEntity(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      source: source,
      distanceKm: dist,
      phone: phone,
      website: website,
      openingHours: openingHours,
      isVerified: isVerified,
    );
  }
}
