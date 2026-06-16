import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/doctor_with_services_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DoctorCard extends StatelessWidget {
  final DoctorWithServicesModel doctor;
  final VoidCallback? onTap;

  const DoctorCard({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'doctor-avatar-${doctor.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: doctor.avatarUrl != null && doctor.avatarUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: doctor.avatarUrl!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: AppColors.surfaceVariant, width: 70, height: 70, child: const Icon(Icons.person, color: AppColors.textSecondary)),
                        errorWidget: (context, url, error) => Container(color: AppColors.surfaceVariant, width: 70, height: 70, child: const Icon(Icons.person, color: AppColors.textSecondary)),
                      )
                    : Container(color: AppColors.surfaceVariant, width: 70, height: 70, child: const Icon(Icons.person, color: AppColors.textSecondary)),
              ),
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
                          doctor.fullName,
                          style: AppTextStyles.headingSm.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.starYellow, size: 14),
                          const SizedBox(width: 4),
                          Text(doctor.rating.toStringAsFixed(1), style: AppTextStyles.labelSm),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(doctor.specialty, style: AppTextStyles.bodySm),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.work_outline, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${doctor.experienceYears} Years Exp.',
                          style: AppTextStyles.bodySm,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.medical_services_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text('${doctor.serviceCount} Services', style: AppTextStyles.bodySm),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: AppColors.accentGreen, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
