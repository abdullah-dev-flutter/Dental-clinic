import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/home_providers.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../../domain/providers/doctor_list_provider.dart';
import '../../widgets/upcoming_appointment_card.dart';
import '../../widgets/home_nearby_clinics_map.dart';

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
    final servicesState = ref.watch(dentalServicesProvider);
    final clinicsState = ref.watch(clinicsProvider);
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
                if (count > 0) {
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
                }
                return const SizedBox();
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
              icon: const Icon(Icons.search, color: AppColors.background),
              onPressed: () {
                context.push('/doctors');
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentProfileProvider);
          ref.invalidate(upcomingAppointmentsProvider);
          ref.invalidate(dentalServicesProvider);
          ref.invalidate(clinicsProvider);
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
                  curve: const Interval(0.0, 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileState.when(
                      data: (profile) => Text(
                        'Hi, ${profile?.fullName?.split(' ').first ?? 'Guest'} 👋',
                        style: AppTextStyles.headingLg,
                      ),
                      loading: () =>
                          Text('Hi... 👋', style: AppTextStyles.headingLg),
                      error: (_, __) =>
                          Text('Hi 👋', style: AppTextStyles.headingLg),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Take care of your smile today!',
                      style: AppTextStyles.bodyMd,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              appointmentsState.when(
                data: (appointments) {
                  if (appointments.isEmpty) return const SizedBox();
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _animController,
                            curve: const Interval(
                              0.2,
                              0.7,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming Appointment',
                          style: AppTextStyles.headingSm,
                        ),
                        const SizedBox(height: 16),
                        UpcomingAppointmentCard(
                          appointment: appointments.first,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Failed to load appointments'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Services', style: AppTextStyles.headingSm),
                  GestureDetector(
                    onTap: () => context.push('/services'),
                    child: Text(
                      'View all',
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: servicesState.when(
                  data: (services) {
                    if (services.isEmpty) {
                      return const Text('No services found.');
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return GestureDetector(
                          onTap: () {
                            ref.read(bookingProvider.notifier).reset();
                            ref
                                .read(doctorSearchProvider.notifier)
                                .setQuery(service.name);
                            context.go('/doctors');
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.accentBlue
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (service.iconUrl != null &&
                                    service.iconUrl!.isNotEmpty)
                                  CachedNetworkImage(
                                    imageUrl: service.iconUrl!,
                                    width: 32,
                                    height: 32,
                                    placeholder: (context, url) => const Icon(
                                      Icons.medical_services,
                                      color: AppColors.textSecondary,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.medical_services,
                                          color: AppColors.textSecondary,
                                        ),
                                  )
                                else
                                  Icon(
                                    Icons.medical_services,
                                    color: index == 0
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                    size: 32,
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  service.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: index == 0
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
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
                  error: (e, st) => const Text('Error loading services'),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nearby Clinic', style: AppTextStyles.headingSm),
                  GestureDetector(
                    onTap: () => context.push('/clinics-map'),
                    child: Text(
                      'View all',
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const HomeNearbyClinicsMap(),
              const SizedBox(height: 16),
              clinicsState.when(
                data: (clinics) {
                  if (clinics.isEmpty) return const Text('No clinics found.');
                  final clinic = clinics.first;
                  return GestureDetector(
                    onTap: () => context.push('/clinics-map'),
                    child: Container(
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
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.accentGreen,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      clinic.name,
                                      style: AppTextStyles.labelMd,
                                    ),
                                    if (clinic.lat !=
                                        null) // Placeholder for distance
                                      Text(
                                        '2.5 km',
                                        style: AppTextStyles.bodySm,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  clinic.address,
                                  style: AppTextStyles.bodySm,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.accentGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Open • Closes ${clinic.closingTime ?? '10:00 PM'}',
                                      style: AppTextStyles.bodySm.copyWith(
                                        color: AppColors.accentGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => const Text('Error loading clinics'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
