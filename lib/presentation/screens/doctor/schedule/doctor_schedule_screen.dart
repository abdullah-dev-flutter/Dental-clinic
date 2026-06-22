import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';

class DoctorScheduleScreen extends ConsumerWidget {
  const DoctorScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Schedule')),
      body: doctorProfile.when(
        data: (doctor) {
          final doctorId = doctor?.id;
          if (doctorId == null || doctorId.isEmpty) {
            return const Center(child: Text('No doctor profile found'));
          }

          final scheduleAsync = ref.watch(doctorScheduleProvider(doctorId));
          final leavesAsync = ref.watch(doctorLeavesProvider(doctorId));

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(doctorScheduleProvider(doctorId));
              ref.invalidate(doctorLeavesProvider(doctorId));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Working Hours', style: AppTextStyles.headingSm),
                const SizedBox(height: 12),
                scheduleAsync.when(
                  data: (schedule) => schedule.isEmpty
                      ? _buildEmptyCard('No working hours configured')
                      : Column(children: schedule.map(_buildScheduleTile).toList()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => _buildEmptyCard('Could not load schedule'),
                ),
                const SizedBox(height: 24),
                Text('Upcoming Leaves', style: AppTextStyles.headingSm),
                const SizedBox(height: 12),
                leavesAsync.when(
                  data: (leaves) => leaves.isEmpty
                      ? _buildEmptyCard('No upcoming leaves')
                      : Column(children: leaves.map(_buildLeaveTile).toList()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => _buildEmptyCard('Could not load leaves'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Failed to load profile')),
      ),
    );
  }

  Widget _buildScheduleTile(Map<String, dynamic> schedule) {
    final isAvailable = schedule['is_available'] as bool? ?? true;
    final start = schedule['start_time']?.toString() ?? '--:--';
    final end = schedule['end_time']?.toString() ?? '--:--';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _dayLabel(schedule['day_of_week']),
              style: isAvailable
                  ? AppTextStyles.bodyMd
                  : const TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w600),
            ),
          ),
          if (!isAvailable)
            const Text('OFF', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w600))
          else
            Row(
              children: [
                Text(start, style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                Text(end, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLeaveTile(Map<String, dynamic> leave) {
    final date = leave['leave_date'] ?? 'N/A';
    final reason = leave['reason'] as String?;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.weekend, color: AppColors.errorRed.withOpacity(0.7), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave on $date', style: AppTextStyles.labelMd),
                if (reason != null && reason.isNotEmpty) Text(reason, style: AppTextStyles.bodySm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text(message)),
    );
  }

  String _dayLabel(Object? value) {
    const names = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    if (value is int && value >= 1 && value <= 7) return names[value - 1];
    if (value is String) {
      final number = int.tryParse(value);
      if (number != null && number >= 1 && number <= 7) return names[number - 1];
      return value;
    }
    return 'Day';
  }
}
