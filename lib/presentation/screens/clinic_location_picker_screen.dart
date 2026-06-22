import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/clinic_location_model.dart';
import '../../data/models/clinic_model.dart';
import '../../domain/providers/clinic_provider.dart';
import '../../domain/providers/location_provider.dart';
import '../../domain/providers/repository_providers.dart';

class ClinicLocationPickerScreen extends ConsumerStatefulWidget {
  const ClinicLocationPickerScreen({super.key});

  @override
  ConsumerState<ClinicLocationPickerScreen> createState() =>
      _ClinicLocationPickerScreenState();
}

class _ClinicLocationPickerScreenState
    extends ConsumerState<ClinicLocationPickerScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  LatLng? _selectedPosition;
  String? _selectedAddress;
  String? _selectedClinicName;
  String? _selectedClinicId;
  bool _isExistingClinic = false;
  bool _isLoadingClinics = false;
  bool _isSearching = false;
  bool _isReverseGeocoding = false;
  String? _searchError;
  List<ClinicModel> _nearbyClinics = [];
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadNearbyClinics();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _loadNearbyClinics() async {
    setState(() => _isLoadingClinics = true);
    try {
      final position = await ref.read(locationProvider.future);
      final current = LatLng(position.latitude, position.longitude);
      _mapController.move(current, 13);
      final clinics = await ref.read(nearbyClinicsProvider(current).future);
      if (!mounted) return;
      setState(() => _nearbyClinics = clinics);
    } catch (_) {
      if (!mounted) return;
      setState(() => _nearbyClinics = []);
    } finally {
      if (mounted) setState(() => _isLoadingClinics = false);
    }
  }

  Future<void> _onMapTap(LatLng position) async {
    setState(() {
      _selectedPosition = position;
      _selectedClinicId = null;
      _selectedClinicName = _searchController.text.trim().isEmpty
          ? 'New Clinic'
          : _searchController.text.trim();
      _selectedAddress = 'Resolving address...';
      _isExistingClinic = false;
      _isReverseGeocoding = true;
      _searchError = null;
      _searchResults = [];
    });

    try {
      final address = await _reverseGeocode(position.latitude, position.longitude);
      if (!mounted) return;
      setState(() {
        _selectedAddress = address;
        _isReverseGeocoding = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _selectedAddress =
            'Selected location (${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)})';
        _isReverseGeocoding = false;
      });
    }
  }

  void _selectExistingClinic(ClinicModel clinic) {
    final position = LatLng(clinic.lat, clinic.lng);
    setState(() {
      _selectedPosition = position;
      _selectedAddress = clinic.address;
      _selectedClinicName = clinic.name;
      _selectedClinicId = clinic.id;
      _isExistingClinic = true;
      _searchError = null;
      _searchResults = [];
    });
    _mapController.move(position, 16);
  }

  Future<void> _onExistingClinicTap(ClinicModel clinic) async {
    _selectExistingClinic(clinic);
    if (!mounted) return;
    await _showClinicBottomSheet(clinic);
  }

  Future<void> _showClinicBottomSheet(ClinicModel clinic) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(clinic.name, style: AppTextStyles.headingSm)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(clinic.address, style: AppTextStyles.bodyMd),
            if (clinic.distanceKm != null) ...[
              const SizedBox(height: 8),
              Text(
                '${clinic.distanceKm!.toStringAsFixed(1)} km away',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _selectExistingClinic(clinic);
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Select This Clinic'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    try {
      final position = await ref.read(locationProvider.future);
      final current = LatLng(position.latitude, position.longitude);
      _mapController.move(current, 15);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not get location: $e'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  Future<void> _handleSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _isSearching = true;
      _searchError = null;
      _searchResults = [];
    });

    try {
      final existingClinics = await ref
          .read(clinicRepositoryProvider)
          .searchClinicsByName(trimmed);

      final results = existingClinics
          .map(
            (clinic) => <String, dynamic>{
              'source': 'existing',
              'id': clinic.id,
              'name': clinic.name,
              'address': clinic.address,
              'lat': clinic.lat,
              'lng': clinic.lng,
              'display_name': clinic.name,
            },
          )
          .toList();

      if (results.isEmpty) {
        final uri = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${Uri.encodeQueryComponent(trimmed)}&format=json&limit=6&addressdetails=1',
        );
        final response = await _nominatimRequest(uri);
        final rows = response is List
            ? response
                .map((e) => Map<String, dynamic>.from(e as Map))
                .map(
                  (row) => <String, dynamic>{
                    'source': 'remote',
                    'display_name': row['display_name'] as String? ?? 'Unnamed result',
                    'address': row['display_name'] as String? ?? 'Selected location',
                    'lat': double.tryParse(row['lat'] as String? ?? '') ?? 0,
                    'lng': double.tryParse(row['lon'] as String? ?? '') ?? 0,
                  },
                )
                .where((row) => (row['lat'] as double) != 0 && (row['lng'] as double) != 0)
                .toList()
            : <Map<String, dynamic>>[];
        results.addAll(rows);
      }

      if (!mounted) return;
      setState(() {
        _searchResults = results;
        _searchError = results.isEmpty ? 'No results found for "$trimmed"' : null;
      });
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  Future<void> _selectSearchResult(Map<String, dynamic> result) async {
    final lat = (result['lat'] as num).toDouble();
    final lng = (result['lng'] as num).toDouble();
    final address = result['address'] as String? ?? result['display_name'] as String? ?? 'Selected location';
    final clinicName = result['name'] as String? ?? address.split(',').first;
    final position = LatLng(lat, lng);
    final isExisting = result['source'] == 'existing';

    setState(() {
      _selectedPosition = position;
      _selectedAddress = address;
      _selectedClinicName = clinicName;
      _selectedClinicId = result['id'] as String?;
      _isExistingClinic = isExisting;
      _searchResults = [];
      _searchError = null;
    });

    _searchFocus.unfocus();
    _mapController.move(position, 16);

    if (isExisting) {
      final clinic = await ref.read(clinicRepositoryProvider).getClinicById(_selectedClinicId!);
      if (clinic != null && mounted) {
        await _showClinicBottomSheet(clinic);
      }
    }
  }

  Future<String> _reverseGeocode(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final addressParts = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((e) => e != null && e.isNotEmpty).toList();
        
        if (addressParts.isNotEmpty) {
          return addressParts.join(', ');
        }
      }
    } catch (e) {
      // Fallback if geocoding fails
    }

    final uri = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1',
    );
    final result = await _nominatimRequest(uri);
    if (result is Map<String, dynamic>) {
      final address = result['display_name'] as String?;
      if (address != null && address.isNotEmpty) return address;
    }
    throw Exception('No address returned');
  }

  Future<dynamic> _nominatimRequest(Uri uri) async {
    try {
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'dental_clinic_app/1.0',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode != 200) return null;
      return jsonDecode(response.body);
    } catch (_) {
      return null;
    }
  }

  void _onConfirm() {
    if (_selectedPosition == null || _selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a clinic location on the map'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    final result = ClinicLocationModel(
      clinicName: _selectedClinicName ?? _selectedAddress!.split(',').first,
      clinicAddress: _selectedAddress!,
      lat: _selectedPosition!.latitude,
      lng: _selectedPosition!.longitude,
      isExistingClinic: _isExistingClinic,
      existingClinicId: _selectedClinicId,
    );

    ref.read(selectedClinicProvider.notifier).state = result;
    context.pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final canConfirm = _selectedPosition != null && _selectedAddress != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocus,
                          onSubmitted: _handleSearch,
                          decoration: InputDecoration(
                            hintText: 'Search clinic name...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _isSearching
                                ? const Padding(
                                    padding: EdgeInsets.all(14),
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.search_rounded),
                                    onPressed: () => _handleSearch(_searchController.text),
                                  ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _goToCurrentLocation,
                        icon: const Icon(Icons.gps_fixed, color: AppColors.accentBlue),
                        style: IconButton.styleFrom(backgroundColor: Colors.white),
                      ),
                    ],
                  ),
                  if (_searchResults.isNotEmpty) _buildSearchResults(),
                  if (_searchError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _searchError!,
                        style: const TextStyle(color: AppColors.errorRed, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: const LatLng(31.5204, 74.3587),
                      initialZoom: 12,
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
                      onTap: (_, point) => _onMapTap(point),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.dental_clinic',
                      ),
                      MarkerLayer(markers: _existingClinicMarkers()),
                      if (_selectedPosition != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _selectedPosition!,
                              width: 50,
                              height: 50,
                              child: const Icon(Icons.location_on, color: Colors.red, size: 48),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (_isLoadingClinics)
                    const Positioned(
                      top: 12,
                      left: 12,
                      right: 12,
                      child: LinearProgressIndicator(),
                    ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: _buildLegend(),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: _goToCurrentLocation,
                      child: const Icon(Icons.my_location, color: AppColors.accentBlue),
                    ),
                  ),
                ],
              ),
            ),
            _buildBottomBar(canConfirm),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(maxHeight: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          final isExisting = result['source'] == 'existing';
          return ListTile(
            dense: true,
            leading: Icon(
              isExisting ? Icons.local_hospital : Icons.place_outlined,
              color: isExisting ? AppColors.accentBlue : AppColors.accentGreen,
            ),
            title: Text(
              result['display_name'] as String? ?? 'Unnamed result',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(isExisting ? 'Existing clinic' : 'New map location'),
            onTap: () => _selectSearchResult(result),
          );
        },
      ),
    );
  }

  List<Marker> _existingClinicMarkers() {
    return _nearbyClinics.map((clinic) {
      return Marker(
        point: LatLng(clinic.lat, clinic.lng),
        width: 40,
        height: 40,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onExistingClinicTap(clinic),
          child: const Icon(Icons.location_on, color: Colors.blue, size: 36),
        ),
      );
    }).toList();
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _legendItem(Icons.location_on, Colors.blue, 'Existing clinics'),
          const SizedBox(height: 4),
          _legendItem(Icons.location_on, Colors.red, 'New location'),
        ],
      ),
    );
  }

  Widget _legendItem(IconData icon, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySm),
      ],
    );
  }

  Widget _buildBottomBar(bool canConfirm) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                _isExistingClinic ? Icons.check_circle : Icons.location_on_outlined,
                color: _selectedPosition != null ? AppColors.accentBlue : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isReverseGeocoding
                      ? 'Resolving selected location...'
                      : _selectedAddress ?? 'Tap map, search clinic, or select a blue pin',
                  style: AppTextStyles.bodySm.copyWith(
                    color: _selectedPosition != null ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: canConfirm ? _onConfirm : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentBlue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.accentBlue.withOpacity(0.35),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('CONFIRM THIS LOCATION'),
            ),
          ),
        ],
      ),
    );
  }
}
