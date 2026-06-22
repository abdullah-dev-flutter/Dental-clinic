import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/clinic_model.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../../domain/providers/nearby_clinic_provider.dart';
import '../../widgets/common/app_button.dart';

class BookServiceScreen extends ConsumerWidget {
  const BookServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final clinicsAsync = ref.watch(nearbyClinicsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Select Services'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (bookingState.selectedClinic != null) ...[
                    _buildSelectionCard(
                      title: 'Selected Clinic',
                      subtitle: bookingState.selectedClinic!.name,
                      icon: Icons.local_hospital,
                      onClear: () => ref.read(bookingProvider.notifier).reset(),
                    ),
                  ] else ...[
                    Text('Select a Clinic', style: AppTextStyles.headingSm),
                    const SizedBox(height: 12),
                    clinicsAsync.when(
                      data: (clinics) {
                        if (clinics.isEmpty) return const Text('No clinics found nearby.');
                        return SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: clinics.length,
                            itemBuilder: (context, index) {
                              final clinic = clinics[index];
                              return GestureDetector(
                                onTap: () async {
                                  final clinicModel = ClinicModel(
                                    id: clinic.id,
                                    name: clinic.name,
                                    address: clinic.address,
                                    lat: clinic.latitude,
                                    lng: clinic.longitude,
                                    isVerified: clinic.isVerified,
                                    distanceKm: clinic.distanceKm,
                                  );
                                  await ref.read(bookingProvider.notifier).selectClinic(clinicModel);
                                },
                                child: Container(
                                  width: 240,
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.local_hospital, color: AppColors.accentBlue, size: 20),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              clinic.name,
                                              style: AppTextStyles.labelMd,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        clinic.address,
                                        style: AppTextStyles.bodySm,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      Text(
                                        clinic.distanceText,
                                        style: AppTextStyles.labelSm.copyWith(color: AppColors.accentGreen),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Text('Error loading clinics: $e'),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text('Select Services', style: AppTextStyles.headingSm),
                  const SizedBox(height: 12),
                  ...dentalServices.map((service) {
                    final isSelected = bookingState.selectedServices.any((s) => s['name'] == service['name']);
                    return GestureDetector(
                      onTap: () => ref.read(bookingProvider.notifier).toggleService(service),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accentBlue.withOpacity(0.1) : AppColors.surface,
                          border: Border.all(
                            color: isSelected ? AppColors.accentBlue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                                    color: isSelected ? AppColors.accentBlue : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(service['name'] as String, style: AppTextStyles.labelMd)),
                                ],
                              ),
                            ),
                            Text(
                              'PKR ${service['price']}',
                              style: AppTextStyles.labelMd.copyWith(
                                color: isSelected ? AppColors.accentBlue : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  if (bookingState.selectedServices.isNotEmpty) _buildBillSummary(bookingState),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: AppButton(
              label: 'Continue to Schedule',
              onPressed: bookingState.selectedServices.isEmpty || bookingState.selectedClinic == null
                  ? null
                  : () => context.push('/book/datetime'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummary(BookingState bookingState) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ...bookingState.selectedServices.map((service) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(service['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    Text('PKR ${service['price']}', style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Colors.white38),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Bill', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              Text('PKR ${bookingState.totalBill}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onClear,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.accentBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodySm),
                Text(subtitle, style: AppTextStyles.labelMd),
              ],
            ),
          ),
          if (onClear != null)
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: onClear,
            ),
        ],
      ),
    );
  }
}
