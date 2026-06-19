import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import '../models/map_clinic_entity.dart';

class OsmRepository {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  // List of public Overpass API instances to use as fallbacks
  final List<String> _endpoints = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
    'https://maps.mail.ru/osm/tools/overpass/api/interpreter',
  ];

  Future<List<MapClinicEntity>> fetchNearbyDentists(LatLng center, double radiusKm) async {
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

    // Try each endpoint in succession if the previous one fails
    for (String endpoint in _endpoints) {
      try {
        final response = await _dio.post(endpoint, data: 'data=$query');
        
        if (response.statusCode == 200) {
          final elements = (response.data['elements'] as List?) ?? [];
          if (elements.isEmpty) return [];
          
          return elements.map((e) {
            final tags = e['tags'] ?? {};
            final lat = e['type'] == 'node' ? e['lat'] : e['center']['lat'];
            final lon = e['type'] == 'node' ? e['lon'] : e['center']['lon'];
            
            return MapClinicEntity(
              id: 'osm_${e['id']}',
              name: tags['name'] ?? 'Dental Clinic',
              address: _buildAddress(tags),
              latitude: (lat as num).toDouble(),
              longitude: (lon as num).toDouble(),
              source: ClinicSource.osm,
              distanceKm: 0.0, // Re-calculated later
              phone: tags['phone'] ?? tags['contact:phone'],
              website: tags['website'] ?? tags['contact:website'],
              openingHours: tags['opening_hours'],
              isVerified: false,
            );
          }).toList();
        }
      } catch (e) {
        // Log error if needed, but continue to the next fallback endpoint
        continue;
      }
    }
    
    // If all endpoints fail, return an empty list
    return [];
  }

  String _buildAddress(Map<String, dynamic> tags) {
    final street = tags['addr:street'];
    final housenumber = tags['addr:housenumber'];
    final city = tags['addr:city'];
    
    List<String> parts = [];
    if (housenumber != null && street != null) {
      parts.add('$housenumber $street');
    } else if (street != null) {
      parts.add(street);
    }
    if (city != null) {
      parts.add(city);
    }
    
    if (parts.isEmpty) return 'Address not available';
    return parts.join(', ');
  }
}
