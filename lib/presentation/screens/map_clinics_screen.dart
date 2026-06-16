import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/providers/location_provider.dart';
import '../../domain/providers/map_providers.dart';
import '../../data/models/map_clinic_entity.dart';

class MapClinicsScreen extends ConsumerStatefulWidget {
  const MapClinicsScreen({super.key});

  @override
  ConsumerState<MapClinicsScreen> createState() => _MapClinicsScreenState();
}

class _MapClinicsScreenState extends ConsumerState<MapClinicsScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final clinicsState = ref.watch(filteredMapClinicsProvider);
    final filterState = ref.watch(mapFilterProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black87),
                  onChanged: (val) => ref.read(mapFilterProvider.notifier).updateSearch(val),
                  decoration: InputDecoration(
                    hintText: 'Search by clinic name, address...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    suffixIcon: const Icon(Icons.search, color: AppColors.accentBlue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // Filter chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterChip(
                    'Partner',
                    filterState.partnerOnly,
                    () => ref.read(mapFilterProvider.notifier).togglePartnerOnly(),
                  ),
                  _buildFilterChip(
                    'OSM',
                    filterState.osmOnly,
                    () => ref.read(mapFilterProvider.notifier).toggleOsmOnly(),
                  ),
                  _buildRadiusChip(ref, filterState.radiusLimit, 5),
                  _buildRadiusChip(ref, filterState.radiusLimit, 10),
                  _buildRadiusChip(ref, filterState.radiusLimit, 20),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Map + List
            Expanded(
              child: locationState.when(
                data: (position) {
                  final userLocation = LatLng(position.latitude, position.longitude);
                  return clinicsState.when(
                    data: (clinics) => _buildMapAndList(context, userLocation, clinics),
                    loading: _buildLoading,
                    error: (error, _) => _buildError(error),
                  );
                },
                loading: _buildLoading,
                error: (error, _) => _buildError(error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black87)),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.white,
        selectedColor: AppColors.accentBlue,
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: isSelected ? AppColors.accentBlue : Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildRadiusChip(WidgetRef ref, double currentRadius, double targetRadius) {
    final isSelected = currentRadius == targetRadius;
    return _buildFilterChip(
      '<${targetRadius.toInt()}km',
      isSelected,
      () => ref.read(mapFilterProvider.notifier).setRadius(targetRadius),
    );
  }

  Widget _buildMapAndList(BuildContext context, LatLng userLocation, List<MapClinicEntity> clinics) {
    final markers = clinics.map((clinic) {
      final isDatabase = clinic.source == ClinicSource.partner;
      return Marker(
        point: LatLng(clinic.latitude, clinic.longitude),
        width: 40,
        height: 40,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _showClinicBottomSheet(context, clinic, userLocation),
          child: Icon(
            Icons.location_on,
            color: isDatabase ? Colors.blue : Colors.green,
            size: 36,
          ),
        ),
      );
    }).toList();

    return Column(
      children: [
        // Map - 60% height
        Expanded(
          flex: 60,
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: userLocation,
                  initialZoom: 12,
                  interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.dental_clinic',
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      markers: markers,
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.accentBlue,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.24), blurRadius: 4)],
                          ),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: userLocation,
                        width: 45,
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.my_location, color: Colors.red, size: 28),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 16,
                top: 16,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () => _mapController.move(userLocation, 12),
                  child: const Icon(Icons.my_location, color: AppColors.accentBlue),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: _buildLegend(),
              ),
            ],
          ),
        ),

        // Clinic list - 40% height
        Expanded(
          flex: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nearby Clinics (${clinics.length})', style: AppTextStyles.headingSm),
                    TextButton.icon(
                      onPressed: () => context.push('/nearby-clinics'),
                      icon: const Icon(Icons.list, size: 18),
                      label: const Text('View All'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: clinics.isEmpty
                    ? const Center(child: Text('No clinics found'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: clinics.length,
                        itemBuilder: (context, index) {
                          final clinic = clinics[index];
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedClinicProvider.notifier).state = clinic;
                              context.push('/clinics/detail');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: clinic.source == ClinicSource.partner
                                          ? AppColors.accentBlue.withValues(alpha: 0.15)
                                          : AppColors.accentGreen.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.local_hospital,
                                      color: clinic.source == ClinicSource.partner
                                          ? AppColors.accentBlue
                                          : AppColors.accentGreen,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(clinic.name, style: AppTextStyles.labelMd, maxLines: 1, overflow: TextOverflow.ellipsis),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${clinic.distanceKm.toStringAsFixed(1)} km \u2022 ${clinic.address}',
                                          style: AppTextStyles.bodySm,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLegendItem(Icons.location_on, Colors.blue, 'Database Clinic'),
          const SizedBox(height: 6),
          _buildLegendItem(Icons.location_on, Colors.green, 'OpenStreetMap Clinic'),
          const SizedBox(height: 6),
          _buildLegendItem(Icons.my_location, Colors.red, 'Your Location'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87)),
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(error.toString(), textAlign: TextAlign.center),
      ),
    );
  }

  void _showClinicBottomSheet(BuildContext context, MapClinicEntity clinic, LatLng userLocation) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (clinic.isVerified && clinic.source == ClinicSource.partner)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentBlue.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('VERIFIED', style: TextStyle(color: AppColors.accentBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          Expanded(
                            child: Text(clinic.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('${clinic.distanceKm.toStringAsFixed(1)} km away', style: const TextStyle(color: AppColors.accentGreen, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 12),
                Expanded(child: Text(clinic.address, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14))),
              ],
            ),
            if (clinic.openingHours != null && clinic.openingHours!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.schedule, size: 20, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clinic.openingHours!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                        const SizedBox(height: 2),
                        Text(
                          _getOpenClosedStatus(clinic.openingHours!),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getOpenClosedStatus(clinic.openingHours!) == 'Open Now'
                                ? AppColors.accentGreen
                                : AppColors.errorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            if (clinic.phone != null && clinic.phone!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.phone, size: 20, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => launchUrl(Uri.parse('tel:${clinic.phone}')),
                    child: Text(clinic.phone!, style: const TextStyle(color: AppColors.accentBlue, fontSize: 14, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ],
            if (clinic.website != null && clinic.website!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.language, size: 20, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => launchUrl(Uri.parse(clinic.website!)),
                      child: Text(clinic.website!, style: const TextStyle(color: AppColors.accentBlue, fontSize: 14, decoration: TextDecoration.underline), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: clinic.source == ClinicSource.partner
                    ? AppColors.accentBlue.withValues(alpha: 0.15)
                    : AppColors.accentGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                clinic.source == ClinicSource.partner ? 'Database Clinic' : 'OpenStreetMap Clinic',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: clinic.source == ClinicSource.partner ? AppColors.accentBlue : AppColors.accentGreen,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      if (clinic.phone != null) launchUrl(Uri.parse('tel:${clinic.phone}'));
                    },
                    icon: const Icon(Icons.call, size: 18),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.textPrimary, side: const BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final url = 'https://www.google.com/maps/dir/?api=1&destination=${clinic.latitude},${clinic.longitude}';
                      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    },
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Directions'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentBlue, foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(selectedClinicProvider.notifier).state = clinic;
                  context.push('/clinics/detail');
                },
                icon: const Icon(Icons.info_outline, size: 18),
                label: const Text('View Full Details'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _getOpenClosedStatus(String openingHours) {
    final now = DateTime.now();
    final dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final today = dayNames[now.weekday - 1];
    if (openingHours.contains('24/7')) return 'Open Now';
    if (openingHours.contains('Closed')) return 'Closed';
    final todayOffPattern = RegExp('$today\\s+off', caseSensitive: false);
    if (todayOffPattern.hasMatch(openingHours)) return 'Closed Today';
    return 'Hours: $openingHours';
  }
}