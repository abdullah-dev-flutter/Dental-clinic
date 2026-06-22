import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../widgets/common/app_avatar.dart';

class DoctorPatientsScreen extends ConsumerWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Patients')),
      body: doctorProfile.when(
        data: (doctor) {
          final doctorId = doctor?.id;
          if (doctorId == null || doctorId.isEmpty) {
            return const Center(child: Text('No doctor profile found'));
          }

          final patientsAsync = ref.watch(doctorPatientsProvider(doctorId));
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(doctorPatientsProvider(doctorId)),
            child: patientsAsync.when(
              data: (patients) {
                if (patients.isEmpty) return _buildEmptyState();
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: patients.length,
                  itemBuilder: (context, index) => _buildPatientCard(patients[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _buildErrorState(ref, doctorId, error.toString()),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load profile: $error')),
      ),
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    final fullName = patient['full_name'] as String? ?? 'Unknown';
    final phone = patient['phone'] as String? ?? 'N/A';
    final imageUrl = patient['avatar_url'] as String?;
    final visits = patient['total_visits'] ?? 0;
    final totalPaid = _toDouble(patient['total_paid']);
    final lastVisit = patient['last_visit'];

    var formattedDate = 'N/A';
    if (lastVisit != null) {
      try {
        formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.parse(lastVisit.toString()));
      } catch (_) {
        formattedDate = lastVisit.toString();
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AppAvatar(url: imageUrl, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName, style: AppTextStyles.labelMd),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(phone, style: AppTextStyles.bodySm),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Last visit: $formattedDate', style: AppTextStyles.bodySm),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$visits visits', style: AppTextStyles.labelSm),
              const SizedBox(height: 4),
              Text(
                'PKR ${totalPaid.toStringAsFixed(0)}',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.accentGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('No patients yet', style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            Text('Patients will appear here after consultations', style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, String doctorId, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
            const SizedBox(height: 16),
            Text('Failed to load patients', style: AppTextStyles.bodyMd),
            const SizedBox(height: 8),
            Text(error, style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(doctorPatientsProvider(doctorId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  double _toDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}
