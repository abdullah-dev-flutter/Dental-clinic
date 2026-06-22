import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/home_providers.dart';
import '../../../domain/providers/nearby_clinic_provider.dart';
import '../../widgets/home_nearby_clinics_map.dart';
import '../../widgets/upcoming_appointment_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(currentProfileProvider);
    final appointmentsState = ref.watch(upcomingAppointmentsProvider);
    final nearbyClinicsState = ref.watch(nearbyClinicsProvider);
    final unreadCountState = ref.watch(unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () => context.push('/notifications'),
            ),
            unreadCountState.maybeWhen(
              data: (count) {
                if (count <= 0) return const SizedBox();
                return Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.errorRed,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count > 9 ? '9+' : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              orElse: () => const SizedBox(),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: AppColors.accentGreen,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.map_outlined, color: AppColors.background),
              onPressed: () => context.go('/clinics-map'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentProfileProvider);
          ref.invalidate(upcomingAppointmentsProvider);
          ref.invalidate(nearbyClinicsProvider);
          ref.invalidate(unreadNotificationCountProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: _animController,
                  curve: const Interval(0, 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileState.when(
                      data: (profile) => Text(
                        'Hi, ${profile?.fullName?.split(' ').first ?? 'Guest'}',
                        style: AppTextStyles.headingLg,
                      ),
                      loading: () => Text('Hi...', style: AppTextStyles.headingLg),
                      error: (_, __) => Text('Hi', style: AppTextStyles.headingLg),
                    ),
                    const SizedBox(height: 4),
                    Text('Find your nearest dental clinic today!', style: AppTextStyles.bodyMd),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              appointmentsState.when(
                data: (appointments) {
                  if (appointments.isEmpty) return const SizedBox();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming Appointment', style: AppTextStyles.headingSm),
                      const SizedBox(height: 16),
                      UpcomingAppointmentCard(appointment: appointments.first),
                      const SizedBox(height: 24),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Failed to load appointments'),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nearby Clinics', style: AppTextStyles.headingSm),
                  GestureDetector(
                    onTap: () => context.push('/clinics-map'),
                    child: Text(
                      'View all',
                      style: AppTextStyles.labelMd.copyWith(color: AppColors.accentGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const HomeNearbyClinicsMap(),
              const SizedBox(height: 16),
              nearbyClinicsState.when(
                data: (clinics) {
                  if (clinics.isEmpty) {
                    return _emptyClinicsCard();
                  }
                  return Column(
                    children: clinics.take(3).map((clinic) {
                      return GestureDetector(
                        onTap: () => context.push('/clinics-map'),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.location_on, color: AppColors.accentGreen),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            clinic.name,
                                            style: AppTextStyles.labelMd,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          clinic.distanceText,
                                          style: AppTextStyles.bodySm.copyWith(
                                            color: AppColors.accentBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      clinic.address,
                                      style: AppTextStyles.bodySm,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                error: (_, __) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Enable location to see nearby clinics', style: AppTextStyles.bodyMd),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyClinicsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.location_off, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'No clinics found within 5km of your location.',
            style: AppTextStyles.bodyMd.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
