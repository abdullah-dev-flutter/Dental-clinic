import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../../domain/providers/repository_providers.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class DoctorProfileScreen extends ConsumerWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // edit action
            },
            child: const Text('Edit', style: TextStyle(color: AppColors.accentBlue)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(doctorProfileProvider);
        },
        child: doctorProfile.when(
          data: (doctor) {
            if (doctor == null) {
              return const Center(child: Text('No profile found'));
            }
            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildAvatarSection(doctor),
                const SizedBox(height: 32),
                _buildInfoSection(context, doctor),
                const SizedBox(height: 24),
                _buildClinicSection(doctor),
                const SizedBox(height: 24),
                _buildQuickLinksSection(context),
                const SizedBox(height: 24),
                _buildSignOutButton(context, ref),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _buildErrorState(error.toString()),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(doctor) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.surfaceVariant,
            backgroundImage: doctor.profileImageUrl != null
                ? NetworkImage(doctor.profileImageUrl!)
                : null,
            child: doctor.profileImageUrl == null
                ? const Icon(Icons.person, size: 48, color: AppColors.textSecondary)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            'Dr. ${doctor.fullName}',
            style: AppTextStyles.headingMd,
          ),
          const SizedBox(height: 4),
          Text(
            doctor.specialization ?? 'Dentist',
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
          ),
          if (doctor.clinicName != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  doctor.clinicName!,
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, doctor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Professional Info', style: AppTextStyles.headingSm),
          const SizedBox(height: 16),
          _buildInfoRow('Email', doctor.email),
          if (doctor.phone != null) _buildInfoRow('Phone', doctor.phone!),
          if (doctor.specialization != null) _buildInfoRow('Specialization', doctor.specialization!),
          if (doctor.pmdcNumber != null) _buildInfoRow('PMDC Number', doctor.pmdcNumber!),
          if (doctor.experienceYears != null) _buildInfoRow('Experience', '${doctor.experienceYears} years'),
          if (doctor.consultationFee != null) _buildInfoRow('Fee', 'PKR ${doctor.consultationFee!.toStringAsFixed(0)}'),
          _buildInfoRow('Rating', '${(doctor.rating ?? 0).toStringAsFixed(1)} ★'),
          _buildInfoRow('Total Patients', '${doctor.totalPatients ?? 0}'),
        ],
      ),
    );
  }

  Widget _buildClinicSection(doctor) {
    if (doctor.clinicLat == null || doctor.clinicLng == null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text('No clinic location set'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clinic Location', style: AppTextStyles.headingSm),
              TextButton(
                onPressed: () {
                  final url =
                      'https://www.google.com/maps/dir/?api=1&destination=${doctor.clinicLat},${doctor.clinicLng}';
                  launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                },
                child: const Text('Directions', style: TextStyle(color: AppColors.accentBlue)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (doctor.clinicAddress != null)
            Text(doctor.clinicAddress!, style: AppTextStyles.bodyMd),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(doctor.clinicLat!, doctor.clinicLng!),
                initialZoom: 14,
                interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.dental_clinic',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(doctor.clinicLat!, doctor.clinicLng!),
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 48),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Links', style: AppTextStyles.headingSm),
        const SizedBox(height: 12),
        _buildLinkTile(context, Icons.calendar_today_outlined, 'Appointments', '/doctor/appointments'),
        _buildLinkTile(context, Icons.schedule_outlined, 'Schedule', '/doctor/schedule'),
        _buildLinkTile(context, Icons.people_outline, 'Patients', '/doctor/patients'),
      ],
    );
  }

  Widget _buildLinkTile(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accentBlue, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: AppTextStyles.bodyMd)),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Sign Out'),
              content: const Text('Are you sure you want to sign out?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Sign Out')),
              ],
            ),
          );
          if (confirm == true && context.mounted) {
            ref.read(authRepositoryProvider).logout();
            context.go('/auth');
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: AppColors.errorRed.withOpacity(0.1),
          foregroundColor: AppColors.errorRed,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Sign Out'),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
            const SizedBox(height: 16),
            Text('Failed to load profile', style: AppTextStyles.bodyMd),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
