import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/map_clinic_entity.dart';

class NearbyClinicCard extends StatelessWidget {
  final MapClinicEntity clinic;
  final VoidCallback? onViewDetails;

  const NearbyClinicCard({super.key, required this.clinic, this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClinicIcon(),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildClinicSummary()),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInfoRow(Icons.location_on_outlined, clinic.address),
          if (clinic.phone != null && clinic.phone!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildInfoRow(Icons.call_outlined, clinic.phone!),
          ],
          if (clinic.openingHours != null &&
              clinic.openingHours!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildInfoRow(Icons.schedule, clinic.openingHours!),
          ],
          const SizedBox(height: AppSpacing.lg),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildClinicIcon() {
    final isDb = clinic.source == ClinicSource.partner;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isDb
            ? AppColors.accentBlue.withValues(alpha: 0.15)
            : AppColors.accentGreen.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(
        Icons.local_hospital_rounded,
        color: isDb ? AppColors.accentBlue : AppColors.accentGreen,
      ),
    );
  }

  Widget _buildClinicSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          clinic.name,
          style: AppTextStyles.headingSm,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${clinic.distanceKm.toStringAsFixed(1)} km away',
          style: AppTextStyles.labelSm.copyWith(color: AppColors.accentGreen),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: clinic.source == ClinicSource.partner
                ? AppColors.accentBlue.withValues(alpha: 0.15)
                : AppColors.accentGreen.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            clinic.source == ClinicSource.partner
                ? 'Database'
                : 'OpenStreetMap',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: clinic.source == ClinicSource.partner
                  ? AppColors.accentBlue
                  : AppColors.accentGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMd,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        if (clinic.phone != null && clinic.phone!.isNotEmpty) ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _launchPhone(clinic.phone!),
              icon: const Icon(Icons.call_outlined),
              label: const Text('Call'),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                onViewDetails ??
                () {
                  // Default: no-op; parent should provide callback
                },
            icon: const Icon(Icons.visibility_outlined),
            label: const Text('View Details'),
          ),
        ),
      ],
    );
  }

  Future<void> _launchPhone(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    await launchUrl(Uri.parse('tel:$cleaned'));
  }
}
