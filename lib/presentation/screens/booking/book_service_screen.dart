import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../../domain/providers/home_providers.dart';
import '../../../domain/providers/doctor_list_provider.dart';
import '../../../domain/providers/nearby_clinic_provider.dart';
import '../../../data/models/map_clinic_entity.dart';
import '../../../data/models/clinic_model.dart';
import '../../widgets/common/app_button.dart';

class BookServiceScreen extends ConsumerStatefulWidget {
  const BookServiceScreen({super.key});

  @override
  ConsumerState<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends ConsumerState<BookServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);
    final servicesAsync = ref.watch(dentalServicesProvider);
    final doctorsAsync = ref.watch(doctorListProvider);

    final clinicsAsync = ref.watch(nearbyClinicsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Booking Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Hospital (Clinic) Selection/Display
                  if (bookingState.selectedClinic == null) ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Select Hospital',
                        style: AppTextStyles.headingSm,
                      ),
                    ),
                    clinicsAsync.when(
                      data: (clinics) => SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: clinics.length,
                          itemBuilder: (context, index) {
                            final clinic = clinics[index];
                            final isSelected =
                                bookingState.selectedClinic?.id == clinic.id;
                            return GestureDetector(
                              onTap: () {
                                final clinicModel = ClinicModel(
                                  id: clinic.id,
                                  name: clinic.name,
                                  address: clinic.address,
                                  lat: clinic.latitude,
                                  lng: clinic.longitude,
                                );
                                ref
                                    .read(bookingProvider.notifier)
                                    .selectClinic(clinicModel);

                                // Automatically go next if service is already selected
                                if (bookingState.selectedService != null) {
                                  context.push('/book/datetime');
                                }
                              },
                              child: Container(
                                width: 220,
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.accentGreen
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            clinic.name,
                                            style: AppTextStyles.labelMd,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          clinic.distanceText,
                                          style: AppTextStyles.labelSm.copyWith(
                                            color: AppColors.accentBlue,
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
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Error loading hospitals: $e'),
                      ),
                    ),
                  ] else ...[
                    _buildSelectionTile(
                      title: 'Hospital',
                      subtitle: bookingState.selectedClinic!.name,
                      trailing: TextButton(
                        onPressed: () {
                          ref.read(bookingProvider.notifier).reset();
                        },
                        child: const Text('Change'),
                      ),
                    ),
                  ],

                  const Divider(height: 32, color: AppColors.divider),

                  // 2. Service Selection
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select Service',
                      style: AppTextStyles.headingSm,
                    ),
                  ),
                  servicesAsync.when(
                    data: (allServices) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: allServices.length,
                        itemBuilder: (context, index) {
                          final service = allServices[index];
                          final isSelected =
                              bookingState.selectedService?.id == service.id;

                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(bookingProvider.notifier)
                                  .selectService(service);

                              // Automatically go next if clinic is already selected
                              if (bookingState.selectedClinic != null) {
                                context.push('/book/datetime');
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.accentGreen
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentBlue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.medical_services,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service.name,
                                          style: AppTextStyles.labelMd,
                                        ),
                                        Text(
                                          'USD ${service.price.toInt()} • ${service.durationMinutes} min',
                                          style: AppTextStyles.bodySm,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle,
                                      color: AppColors.accentGreen,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('Error: $e')),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: AppButton(
              label: 'Continue to Schedule',
              onPressed:
                  bookingState.selectedService == null ||
                      bookingState.selectedClinic == null
                  ? null
                  : () {
                      context.push('/book/datetime');
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionTile({
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodySm),
                Text(subtitle, style: AppTextStyles.labelMd),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
