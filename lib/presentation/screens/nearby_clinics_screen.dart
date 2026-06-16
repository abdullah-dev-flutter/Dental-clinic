import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/providers/map_providers.dart';
import '../../data/models/map_clinic_entity.dart';
import '../widgets/nearby_clinic_card.dart';

class NearbyClinicsScreen extends ConsumerWidget {
  const NearbyClinicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinicsState = ref.watch(allMapClinicsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(allMapClinicsProvider),
          ),
        ],
      ),
      body: clinicsState.when(
        data: (clinics) => _buildContent(ref, clinics),
        loading: _buildLoading,
        error: (error, _) => _buildError(
          message: _friendlyError(error),
          onRetry: () => ref.invalidate(allMapClinicsProvider),
        ),
      ),
    );
  }

  Widget _buildContent(WidgetRef ref, List<MapClinicEntity> clinics) {
    if (clinics.isEmpty) return _buildEmpty();

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(allMapClinicsProvider),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: clinics.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildHeader(clinics.length);
          return NearbyClinicCard(
            clinic: clinics[index - 1],
            onViewDetails: () {
              ref.read(selectedClinicProvider.notifier).state = clinics[index - 1];
              context.push('/clinics/detail');
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(
        '$count clinics found nearby',
        style: AppTextStyles.bodyMd,
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError({required String message, required VoidCallback onRetry}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_off_outlined,
              color: AppColors.textSecondary,
              size: 56,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Text(
          'No clinics found nearby. Try again from a different location.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMd,
        ),
      ),
    );
  }

  String _friendlyError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('permission')) {
      return 'Location permission is required to find nearby clinics.';
    }
    if (message.contains('disabled')) {
      return 'Please enable location services and try again.';
    }
    return 'Unable to load nearby clinics. Please try again.';
  }
}
