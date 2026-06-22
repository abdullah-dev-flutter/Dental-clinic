import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/upcoming_appointment_model.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../../domain/providers/repository_providers.dart';
import '../../../widgets/common/app_avatar.dart';
import '../../../widgets/common/app_button.dart';


class DoctorAppointmentsScreen extends ConsumerStatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  ConsumerState<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends ConsumerState<DoctorAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.accentBlue,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.accentBlue,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: doctorProfile.when(
        data: (doctor) {
          if (doctor == null || doctor.id.isEmpty) {
            return const Center(child: Text('No doctor profile found'));
          }

          final appointmentsAsync = ref.watch(doctorAppointmentsProvider(doctor.id));
          return appointmentsAsync.when(
            data: (appointments) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(doctorAppointmentsProvider(doctor.id));
                },
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAppointmentList(appointments, 'today'),
                    _buildAppointmentList(appointments, 'upcoming'),
                    _buildAppointmentList(appointments, 'completed'),
                    _buildAppointmentList(appointments, 'cancelled'),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => _buildErrorState(error.toString(), doctor.id),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load profile: $error')),
      ),
    );
  }

  Widget _buildAppointmentList(List<UpcomingAppointmentModel> appointments, String filter) {
    final filtered = _filterAppointments(appointments, filter);
    if (filtered.isEmpty) {
      return _buildEmptyState(filter);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _buildAppointmentCard(filtered[index]),
    );
  }

  List<UpcomingAppointmentModel> _filterAppointments(
    List<UpcomingAppointmentModel> appointments,
    String filter,
  ) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return appointments.where((appointment) {
      final status = appointment.status;
      final appointmentDate = DateFormat('yyyy-MM-dd').format(appointment.appointmentDate);
      switch (filter) {
        case 'today':
          return appointmentDate == today;
        case 'upcoming':
          return appointmentDate.compareTo(today) >= 0 &&
              status != 'completed' &&
              status != 'cancelled';
        case 'completed':
          return status == 'completed';
        case 'cancelled':
          return status == 'cancelled';
        default:
          return true;
      }
    }).toList();
  }

  Widget _buildAppointmentCard(UpcomingAppointmentModel appt) {
    final patientName = appt.patientName ?? 'Unknown Patient';
    final patientImage = null; // Update if avatar is available
    final appointmentTime = appt.startTime;
    final status = appt.status;
    final service = appt.service ?? appt.serviceName ?? 'Consultation';
    final paymentMethod = appt.paymentMethod;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.push('/doctor/appointment/${appt.id}'),
        child: Column(
          children: [
            Row(
              children: [
                AppAvatar(url: patientImage, size: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patientName, style: AppTextStyles.labelMd),
                      const SizedBox(height: 4),
                      Text(
                        service,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatTime(appointmentTime),
                      style: AppTextStyles.labelSm.copyWith(color: AppColors.accentBlue),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusBadge(status),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: AppColors.surfaceVariant),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paymentMethod == null || paymentMethod.isEmpty ? 'Not paid' : paymentMethod,
                  style: AppTextStyles.bodySm.copyWith(
                    color: paymentMethod == null || paymentMethod.isEmpty
                        ? AppColors.textSecondary
                        : AppColors.successGreen,
                  ),
                ),
                TextButton(
                  onPressed: () => _showAppointmentDetail(context, appt),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'View Details',
                    style: AppTextStyles.labelSm.copyWith(color: AppColors.accentBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time) {
    if (time.isEmpty) return 'N/A';
    final parts = time.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final minute = parts.length > 1 ? parts[1] : '00';
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'upcoming':
      case 'pending':
      case 'confirmed':
        color = AppColors.accentBlue;
        text = 'Upcoming';
        break;
      case 'completed':
        color = AppColors.successGreen;
        text = 'Completed';
        break;
      case 'cancelled':
        color = AppColors.errorRed;
        text = 'Cancelled';
        break;
      case 'no_show':
        color = AppColors.starYellow;
        text = 'No Show';
        break;
      default:
        color = AppColors.textSecondary;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySm.copyWith(color: color, fontSize: 10),
      ),
    );
  }

  Widget _buildEmptyState(String status) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No $status appointments',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error, String doctorId) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
            const SizedBox(height: 16),
            Text('Failed to load appointments', style: AppTextStyles.bodyMd),
            const SizedBox(height: 8),
            Text(error, style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            AppButton(
              label: 'Retry',
              onPressed: () => ref.invalidate(doctorAppointmentsProvider(doctorId)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppointmentDetail(BuildContext context, UpcomingAppointmentModel appointment) {
    showModalBottomSheet<void>(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appointment #${appointment.id.substring(0, 8)}',
                  style: AppTextStyles.headingMd,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _detailRow('Status', appointment.status),
            _detailRow('Date', DateFormat('yyyy-MM-dd').format(appointment.appointmentDate)),
            _detailRow(
              'Time',
              '${appointment.startTime} - ${appointment.endTime}',
            ),
            _detailRow('Service', appointment.service ?? appointment.serviceName ?? 'Consultation'),
            _detailRow('Payment', appointment.paymentMethod ?? 'Pending'),
            // if (appointment.notes != null)
            //   _detailRow('Notes', appointment.notes.toString()),
            const SizedBox(height: 20),
            if (appointment.status == 'upcoming')
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Mark Completed',
                      color: AppColors.successGreen,
                      onPressed: () async {
                        Navigator.pop(context);
                        await _updateAppointmentStatus(appointment.id, 'completed');
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Cancel',
                      isOutlined: true,
                      onPressed: () async {
                        Navigator.pop(context);
                        await _updateAppointmentStatus(appointment.id, 'cancelled');
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateAppointmentStatus(String appointmentId, String status) async {
    try {
      await ref.read(doctorRepositoryProvider).updateAppointmentStatus(
            appointmentId: appointmentId,
            status: status,
          );
      final doctorId = ref.read(doctorProfileProvider).value?.id;
      if (doctorId != null && doctorId.isNotEmpty) {
        ref.invalidate(doctorAppointmentsProvider(doctorId));
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment marked as $status')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.errorRed),
      );
    }
  }
}
