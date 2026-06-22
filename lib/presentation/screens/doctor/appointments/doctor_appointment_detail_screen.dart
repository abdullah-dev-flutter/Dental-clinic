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
import '../../../widgets/common/app_text_field.dart';

class DoctorAppointmentDetailScreen extends ConsumerStatefulWidget {
  final String appointmentId;
  const DoctorAppointmentDetailScreen({super.key, required this.appointmentId});

  @override
  ConsumerState<DoctorAppointmentDetailScreen> createState() => _DoctorAppointmentDetailScreenState();
}

class _DoctorAppointmentDetailScreenState extends ConsumerState<DoctorAppointmentDetailScreen> {
  final _prescriptionCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  UpcomingAppointmentModel? _appointment;

  @override
  void initState() {
    super.initState();
    _loadAppointment();
  }

  @override
  void dispose() {
    _prescriptionCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAppointment() async {
    try {
      final response = await ref.read(doctorRepositoryProvider).getAppointmentById(
            widget.appointmentId,
          );

      if (!mounted) return;
      setState(() => _appointment = response);
      // Not saving prescription/notes inside view directly, they are separate or part of notes
      _notesCtrl.text = '';
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading appointment: $e'), backgroundColor: AppColors.errorRed),
      );
    }
  }

  Future<void> _updateStatus(String newStatus) async {
    try {
      await ref.read(doctorRepositoryProvider).updateAppointmentStatus(
            appointmentId: widget.appointmentId,
            status: newStatus,
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment marked as $newStatus')),
      );
      await _loadAppointment();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.errorRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Appointment Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _appointment == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPatientInfoCard(),
                  const SizedBox(height: 24),
                  _buildAppointmentDetails(),
                  const SizedBox(height: 24),
                  _buildSymptoms(),
                  const SizedBox(height: 24),
                  Text('Prescription', style: AppTextStyles.headingMd),
                  const SizedBox(height: 12),
                  AppTextField(
                    hint: 'Write prescription here...',
                    controller: _prescriptionCtrl,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  Text('Doctor Notes (Private)', style: AppTextStyles.headingMd),
                  const SizedBox(height: 12),
                  AppTextField(
                    hint: 'Add private notes about this visit...',
                    controller: _notesCtrl,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildPatientInfoCard() {
    final patientName = _appointment!.patientName ?? 'Unknown';
    final patientPhone = _appointment!.patientPhone ?? 'N/A';
    final patientImage = null; // No avatar in UpcomingAppointmentModel

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AppAvatar(url: patientImage, size: 60),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patientName, style: AppTextStyles.headingMd),
                const SizedBox(height: 4),
                Text(patientPhone, style: AppTextStyles.bodySm),
                Text('Age/Gender: N/A', style: AppTextStyles.bodySm),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.accentBlue),
            onPressed: () {
              // View patient history
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    final status = _appointment!.status;
    final date = DateFormat('yyyy-MM-dd').format(_appointment!.appointmentDate);
    final startTime = _appointment!.startTime;
    final endTime = _appointment!.endTime;
    final service = _appointment!.service ?? _appointment!.serviceName ?? 'Consultation';
    final paymentMethod = _appointment!.paymentMethod ?? 'Pending';
    final cost = _appointment!.cost?.toString() ?? '0';

    Color statusColor;
    switch (status) {
      case 'upcoming':
      case 'pending':
      case 'confirmed':
        statusColor = AppColors.accentBlue;
        break;
      case 'completed':
        statusColor = AppColors.successGreen;
        break;
      case 'cancelled':
        statusColor = AppColors.errorRed;
        break;
      default:
        statusColor = AppColors.textSecondary;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Appointment Info', style: AppTextStyles.headingMd),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildInfoRow('Date', date),
              const Divider(color: AppColors.surfaceVariant, height: 24),
              _buildInfoRow('Time', '$startTime - $endTime'),
              const Divider(color: AppColors.surfaceVariant, height: 24),
              _buildInfoRow('Type', service),
              const Divider(color: AppColors.surfaceVariant, height: 24),
              _buildInfoRow('Status', status, color: statusColor),
              const Divider(color: AppColors.surfaceVariant, height: 24),
              _buildInfoRow('Payment', '$paymentMethod (PKR $cost)', color: paymentMethod.isNotEmpty ? AppColors.successGreen : null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptoms() {
    final notes = 'No symptoms reported'; // Not returned in UpcomingAppointmentModel normally
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Symptoms / Reason for visit', style: AppTextStyles.headingMd),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(notes, style: AppTextStyles.bodyMd),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final status = _appointment!.status;

    return Column(
      children: [
        if (status == 'upcoming') ...[
          AppButton(
            label: 'Mark as Completed',
            color: AppColors.successGreen,
            onPressed: () => _updateStatus('completed'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'No Show',
                  isOutlined: true,
                  onPressed: () => _updateStatus('no_show'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  label: 'Cancel',
                  color: AppColors.errorRed,
                  onPressed: () => _updateStatus('cancelled'),
                ),
              ),
            ],
          ),
        ] else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.textSecondary),
                const SizedBox(width: 12),
                Text('This appointment is $status', style: AppTextStyles.bodyMd),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
        Text(value, style: AppTextStyles.labelMd.copyWith(color: color ?? AppColors.textPrimary)),
      ],
    );
  }
}
