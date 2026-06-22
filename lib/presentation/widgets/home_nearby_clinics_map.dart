import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/providers/location_provider.dart';
import '../../domain/providers/nearby_clinic_provider.dart';

class HomeNearbyClinicsMap extends ConsumerWidget {
  const HomeNearbyClinicsMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    final clinicsState = ref.watch(nearbyClinicsProvider);

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: locationState.when(
        data: (position) {
          final userLocation = LatLng(position.latitude, position.longitude);
          return clinicsState.when(
            data: (clinics) {
              return Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: userLocation,
                      initialZoom: 13,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.dental_clinic',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.my_location,
                              color: AppColors.accentBlue,
                              size: 24,
                            ),
                          ),
                          ...clinics.map(
                            (clinic) => Marker(
                              point: LatLng(
                                clinic.latitude,
                                clinic.longitude,
                              ),
                                  width: 40,
                                  height: 40,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _showClinic(
                                      context,
                                      clinic.name,
                                      clinic.address,
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: AppColors.errorRed,
                                      size: 30,
                                    ),
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: AppSpacing.md,
                    right: AppSpacing.md,
                    child: GestureDetector(
                      onTap: () => context.push('/clinics-map'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.fullscreen,
                              size: 18,
                              color: AppColors.accentBlue,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              'View Map',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.accentBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Location Error: $e')),
      ),
    );
  }

  void _showClinic(BuildContext context, String name, String address) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ListTile(
        title: Text(name),
        subtitle: Text(address),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
