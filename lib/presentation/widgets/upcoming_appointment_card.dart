import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/upcoming_appointment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'common/app_badge.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final UpcomingAppointmentModel appointment;
  final bool showBadge;

  const UpcomingAppointmentCard({super.key, required this.appointment, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: appointment.serviceIcon != null && appointment.serviceIcon!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: appointment.serviceIcon!,
                    width: 24,
                    height: 24,
                    placeholder: (context, url) => const Icon(Icons.local_hospital, size: 24),
                    errorWidget: (context, url, error) => const Icon(Icons.local_hospital, size: 24),
                  )
                : const Icon(Icons.local_hospital, size: 24),
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
                        appointment.serviceName ?? 'Unknown Service',
                        style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (showBadge && appointment.status == 'upcoming')
                      const AppBadge(label: 'Upcoming'),
                  ],
                ),
                const SizedBox(height: 4),
                Text(appointment.doctorName ?? 'Unknown Doctor', style: AppTextStyles.bodySm),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${appointment.appointmentDate.formattedDate} • ${formatTimeString(appointment.startTime)} - ${formatTimeString(appointment.endTime)}',
                        style: AppTextStyles.bodySm,
                      ),
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
}
