import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/dental_service_model.dart';

class ServiceItemCard extends StatelessWidget {
  final DentalServiceModel service;
  final VoidCallback? onTap;

  const ServiceItemCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: service.iconUrl != null && service.iconUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: service.iconUrl!,
                      width: 32,
                      height: 32,
                      placeholder: (context, url) => const Icon(Icons.medical_services, size: 32, color: Colors.white),
                      errorWidget: (context, url, error) => const Icon(Icons.medical_services, size: 32, color: Colors.white),
                    )
                  : const Icon(Icons.medical_services, size: 32, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppTextStyles.labelMd.copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    service.description ?? '',
                    style: AppTextStyles.bodySm,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
