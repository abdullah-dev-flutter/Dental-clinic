class NearbyClinicModel {
  final String id;
  final String name;
  final String address;
  final String? phone;
  final String? website;
  final String? openingHours;
  final bool isVerified;
  final double? latitude;
  final double? longitude;
  final double distanceKm;

  const NearbyClinicModel({
    required this.id,
    required this.name,
    required this.address,
    this.phone,
    this.website,
    this.openingHours,
    this.isVerified = false,
    this.latitude,
    this.longitude,
    required this.distanceKm,
  });

  factory NearbyClinicModel.fromJson(Map<String, dynamic> json) {
    return NearbyClinicModel(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Dental Clinic',
      address: json['address'] as String? ?? 'Address not available',
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      openingHours: json['opening_hours'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      latitude: _toDouble(json['lat'] ?? json['latitude']),
      longitude: _toDouble(json['lng'] ?? json['longitude']),
      distanceKm: _toDouble(json['distance_km']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'website': website,
      'opening_hours': openingHours,
      'is_verified': isVerified,
      'lat': latitude,
      'lng': longitude,
      'distance_km': distanceKm,
    };
  }

  NearbyClinicModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? website,
    String? openingHours,
    bool? isVerified,
    double? latitude,
    double? longitude,
    double? distanceKm,
  }) {
    return NearbyClinicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      openingHours: openingHours ?? this.openingHours,
      isVerified: isVerified ?? this.isVerified,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }

  String get distanceText {
    if (distanceKm < 1) return '${(distanceKm * 1000).round()} m';
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  static double? _toDouble(Object? value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
