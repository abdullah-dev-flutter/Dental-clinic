import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/upcoming_appointment_model.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../widgets/common/app_avatar.dart';

class DoctorDashboardScreen extends ConsumerWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(doctorProfileProvider);
            final doctorId = doctorProfile.value?.id;
            if (doctorId != null && doctorId.isNotEmpty) {
              ref.invalidate(doctorTodayStatsProvider(doctorId));
              ref.invalidate(doctorAppointmentsProvider(doctorId));
              ref.invalidate(doctorPatientsProvider(doctorId));
              ref.invalidate(doctorWeeklyAppointmentsProvider(doctorId));
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(doctorProfile),
                const SizedBox(height: 32),
                _buildStatsGrid(ref, doctorProfile.value?.id),
                const SizedBox(height: 24),
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildWeeklySnapshot(ref, doctorProfile.value?.id),
                const SizedBox(height: 32),
                _buildTodayAppointments(context, ref, doctorProfile.value?.id),
                const SizedBox(height: 32),
                _buildRecentPatients(context, ref, doctorProfile.value?.id),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AsyncValue doctorProfileAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good morning,', style: AppTextStyles.bodyMd),
            doctorProfileAsync.when(
              data: (doctor) => Text(
                'Dr. ${doctor?.fullName.split(' ').first ?? ''}',
                style: AppTextStyles.headingLg,
              ),
              loading: () => const SizedBox(
                height: 28,
                width: 150,
                child: LinearProgressIndicator(color: AppColors.surfaceVariant),
              ),
              error: (_, __) => Text('Doctor', style: AppTextStyles.headingLg),
            ),
          ],
        ),
        doctorProfileAsync.when(
          data: (doctor) => AppAvatar(url: doctor?.profileImageUrl, size: 48),
          loading: () => const CircleAvatar(radius: 24, backgroundColor: AppColors.surfaceVariant),
          error: (_, __) => const CircleAvatar(radius: 24, backgroundColor: AppColors.surfaceVariant),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(WidgetRef ref, String? doctorId) {
    if (doctorId == null || doctorId.isEmpty) {
      return const Center(child: Text('No doctor profile found'));
    }

    final statsAsync = ref.watch(doctorTodayStatsProvider(doctorId));
    return statsAsync.when(
      data: (stats) {
        final earnings = (stats['todayEarnings'] as num?)?.toDouble() ?? 0;
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(
              'Today Appts',
              '${stats['totalAppointments'] ?? 0}',
              Icons.people_outline,
              AppColors.accentBlue,
            ),
            _buildStatCard(
              'Pending',
              '${stats['pendingAppointments'] ?? 0}',
              Icons.pending_actions,
              AppColors.accentGreen,
            ),
            _buildStatCard(
              'Completed',
              '${stats['completedAppointments'] ?? 0}',
              Icons.check_circle_outline,
              AppColors.successGreen,
            ),
            _buildStatCard(
              'Today Earned',
              'PKR ${earnings.toStringAsFixed(0)}',
              Icons.attach_money,
              AppColors.starYellow,
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => _buildErrorCard('Could not load dashboard stats'),
    );
  }

  Widget _buildWeeklySnapshot(WidgetRef ref, String? doctorId) {
    if (doctorId == null || doctorId.isEmpty) return const SizedBox.shrink();
    final weeklyAsync = ref.watch(doctorWeeklyAppointmentsProvider(doctorId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Snapshot', style: AppTextStyles.headingMd),
        const SizedBox(height: 12),
        weeklyAsync.when(
          data: (items) {
            if (items.isEmpty) return _buildEmptyCard('No weekly appointment data yet');
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: items.map((item) {
                  final day = item['day']?.toString() ?? 'Day';
                  final count = (item['count'] as num?)?.toInt() ?? 0;
                  final progress = count == 0 ? 0.0 : ((count / 10).clamp(0.1, 1.0) as double);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        SizedBox(width: 64, child: Text(day, style: AppTextStyles.bodySm)),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: AppColors.surfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('$count', style: AppTextStyles.labelSm),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => _buildErrorCard('Could not load weekly data'),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.headingMd),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.power_settings_new, 'Available', AppColors.accentGreen, () {
          context.go('/doctor/schedule');
        }),
        _buildActionButton(Icons.event_busy, 'Add Leave', AppColors.errorRed, () {
          context.go('/doctor/schedule');
        }),
        _buildActionButton(Icons.calendar_month, 'Schedule', AppColors.accentBlue, () {
          context.go('/doctor/schedule');
        }),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelSm),
        ],
      ),
    );
  }

  Widget _buildTodayAppointments(BuildContext context, WidgetRef ref, String? doctorId) {
    if (doctorId == null || doctorId.isEmpty) return const SizedBox.shrink();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final appointmentsAsync = ref.watch(doctorAppointmentsProvider(doctorId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Appointments", style: AppTextStyles.headingMd),
        const SizedBox(height: 16),
        appointmentsAsync.when(
          data: (appointments) {
            final todayAppointments = appointments
                .where((item) => DateFormat('yyyy-MM-dd').format(item.appointmentDate) == today)
                .toList();
            if (todayAppointments.isEmpty) {
              return _buildEmptyCard('No appointments today');
            }
            final next = todayAppointments.first;
            final patientName = next.patientName ?? 'Patient';
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  AppAvatar(url: null, size: 48), // Assuming no avatar in UpcomingAppointmentModel
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patientName,
                          style: AppTextStyles.labelMd.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${next.service ?? next.serviceName ?? 'Consultation'} - ${next.startTime}',
                          style: AppTextStyles.bodySm.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/doctor/appointment/${next.id}'),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildEmptyCard('Failed to load appointments: $error'),
        ),
      ],
    );
  }

  Widget _buildRecentPatients(BuildContext context, WidgetRef ref, String? doctorId) {
    if (doctorId == null || doctorId.isEmpty) return const SizedBox.shrink();
    final patientsAsync = ref.watch(doctorPatientsProvider(doctorId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Patients', style: AppTextStyles.headingMd),
            TextButton(
              onPressed: () => context.push('/doctor/patients'),
              child: Text('See All', style: AppTextStyles.labelSm.copyWith(color: AppColors.accentBlue)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        patientsAsync.when(
          data: (patients) {
            if (patients.isEmpty) return _buildEmptyCard('No patients yet');

            return Column(
              children: patients.take(3).map((patient) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      AppAvatar(url: patient['avatar_url'] as String?, size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patient['full_name'] as String? ?? 'Patient', style: AppTextStyles.labelMd),
                            const SizedBox(height: 4),
                            Text('Last visit: ${patient['last_visit'] ?? 'N/A'}', style: AppTextStyles.bodySm),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (_, __) => _buildErrorCard('Could not load patients'),
        ),
      ],
    );
  }

  Widget _buildEmptyCard(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(message)),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.errorRed.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(message, style: const TextStyle(color: AppColors.errorRed)),
    );
  }
}
