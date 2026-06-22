import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/map_providers.dart';
import '../../../data/models/map_clinic_entity.dart';
import '../../widgets/home_nearby_clinics_map.dart';

class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({super.key});

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clinicsAsync = ref.watch(allMapClinicsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors & Clinics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push('/clinics-map'),
          ),
        ],
      ),
      body: clinicsAsync.when(
        data: (clinics) => _buildContent(context, clinics),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load clinics: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<MapClinicEntity> clinics) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const HomeNearbyClinicsMap(),
        const SizedBox(height: 24),
        Text('Nearby Dental Clinics', style: AppTextStyles.headingSm),
        const SizedBox(height: 12),
        if (clinics.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('No nearby clinics found'),
          )
        else
          ...clinics.take(10).map(_buildClinicTile),
      ],
    );
  }

  Widget _buildClinicTile(MapClinicEntity clinic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.accentBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(clinic.name, style: AppTextStyles.labelMd),
                const SizedBox(height: 4),
                Text(clinic.address, style: AppTextStyles.bodySm),
              ],
            ),
          ),
          Text(clinic.distanceText, style: AppTextStyles.labelSm),
        ],
      ),
    );
  }
}
