import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../models/map_clinic_entity.dart';

class OsmRepository {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  final List<String> _endpoints = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
    'https://maps.mail.ru/osm/tools/overpass/api/interpreter',
  ];

  Future<List<MapClinicEntity>> fetchNearbyDentists(
    LatLng center,
    double radiusKm,
  ) async {
    final radiusMeters = radiusKm * 1000;
    final query = '''
      [out:json][timeout:15];
      (
        node["amenity"="dentist"](around:$radiusMeters,${center.latitude},${center.longitude});
        node["healthcare"="dentist"](around:$radiusMeters,${center.latitude},${center.longitude});
        way["amenity"="dentist"](around:$radiusMeters,${center.latitude},${center.longitude});
        relation["amenity"="dentist"](around:$radiusMeters,${center.latitude},${center.longitude});
      );
      out center;
    ''';

    for (final endpoint in _endpoints) {
      try {
        final response = await _dio.post(endpoint, data: 'data=$query');
        if (response.statusCode != 200) continue;

        final elements = (response.data['elements'] as List?) ?? [];
        return elements.map((e) {
          final element = Map<String, dynamic>.from(e as Map);
          final tags = Map<String, dynamic>.from(element['tags'] as Map? ?? {});
          final latitude = element['type'] == 'node'
              ? element['lat']
              : (element['center'] as Map)['lat'];
          final longitude = element['type'] == 'node'
              ? element['lon']
              : (element['center'] as Map)['lon'];

          return MapClinicEntity(
            id: 'osm_${element['id']}',
            name: tags['name'] as String? ?? 'Dental Clinic',
            address: _buildAddress(tags),
            latitude: (latitude as num).toDouble(),
            longitude: (longitude as num).toDouble(),
            source: ClinicSource.osm,
            distanceKm: 0,
            phone: tags['phone'] as String? ?? tags['contact:phone'] as String?,
            website: tags['website'] as String? ?? tags['contact:website'] as String?,
            openingHours: tags['opening_hours'] as String?,
          );
        }).toList();
      } catch (_) {
        continue;
      }
    }

    return [];
  }

  String _buildAddress(Map<String, dynamic> tags) {
    final street = tags['addr:street'];
    final houseNumber = tags['addr:housenumber'];
    final city = tags['addr:city'];

    final parts = <String>[];
    if (houseNumber != null && street != null) {
      parts.add('$houseNumber $street');
    } else if (street != null) {
      parts.add(street.toString());
    }
    if (city != null) parts.add(city.toString());

    if (parts.isEmpty) return 'Address not available';
    return parts.join(', ');
  }
}
