import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/upcoming_appointment_model.dart';
import 'common/app_badge.dart';

class UpcomingAppointmentCard extends StatefulWidget {
  final UpcomingAppointmentModel appointment;
  final bool showBadge;
  final bool isExpandable;
  final VoidCallback? onCancel;

  const UpcomingAppointmentCard({
    super.key,
    required this.appointment,
    this.showBadge = false,
    this.isExpandable = false,
    this.onCancel,
  });

  @override
  State<UpcomingAppointmentCard> createState() => _UpcomingAppointmentCardState();
}

class _UpcomingAppointmentCardState extends State<UpcomingAppointmentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isExpandable) return;
        setState(() => _isExpanded = !_isExpanded);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_hospital, color: AppColors.accentBlue, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.appointment.service ??
                                  widget.appointment.serviceName ??
                                  'Dental Appointment',
                              style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.showBadge && widget.appointment.status == 'upcoming')
                            const AppBadge(label: 'Upcoming'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(widget.appointment.clinicName ?? 'Dental Clinic', style: AppTextStyles.bodySm),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${widget.appointment.appointmentDate.formattedDate} • ${formatTimeString(widget.appointment.startTime)} - ${formatTimeString(widget.appointment.endTime)}',
                              style: AppTextStyles.bodySm,
                            ),
                          ),
                        ],
                      ),
                      if (widget.appointment.cost != null || widget.appointment.paymentMethod != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.appointment.cost != null)
                              Text(
                                'PKR ${widget.appointment.cost!.toInt()}',
                                style: AppTextStyles.labelMd.copyWith(color: AppColors.accentBlue),
                              ),
                            if (widget.appointment.paymentMethod != null)
                              Row(
                                children: [
                                  Icon(
                                    widget.appointment.paymentMethod == 'card'
                                        ? Icons.credit_card
                                        : Icons.money,
                                    size: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.appointment.paymentMethod == 'card' ? 'Card' : 'Cash',
                                    style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded ? _buildExpandedContent() : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Divider(height: 1, color: AppColors.surfaceVariant),
        const SizedBox(height: 16),
        Text('Details', style: AppTextStyles.labelMd),
        const SizedBox(height: 8),
        if (widget.appointment.patientName != null)
          _detailRow(Icons.person_outline, 'Patient: ${widget.appointment.patientName}'),
        if (widget.appointment.patientPhone != null)
          _detailRow(Icons.phone_outlined, widget.appointment.patientPhone!),
        if (widget.appointment.servicesSelected != null && widget.appointment.servicesSelected!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Selected Services:', style: AppTextStyles.labelMd),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: widget.appointment.servicesSelected!.map((service) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(service['name']?.toString() ?? '', style: AppTextStyles.bodySm),
                      Text('PKR ${service['price']}', style: AppTextStyles.labelSm),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
        const SizedBox(height: 16),
        if (widget.appointment.status == 'upcoming' && widget.onCancel != null)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: widget.onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.errorRed,
                side: const BorderSide(color: AppColors.errorRed),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Cancel Appointment'),
            ),
          ),
      ],
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTextStyles.bodySm)),
        ],
      ),
    );
  }
}
