import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/doctor_with_services_model.dart';
import '../../../data/models/dental_service_model.dart';
import '../../../data/models/review_model.dart';
import '../../../domain/providers/doctor_list_provider.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/common/app_button.dart';

class DoctorProfileScreen extends ConsumerStatefulWidget {
  final String doctorId;
  final DoctorWithServicesModel? initialDoctor;
  const DoctorProfileScreen({
    super.key,
    required this.doctorId,
    this.initialDoctor,
  });

  @override
  ConsumerState<DoctorProfileScreen> createState() =>
      _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends ConsumerState<DoctorProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorAsync = ref.watch(doctorByIdProvider(widget.doctorId));
    final servicesAsync = ref.watch(doctorServicesProvider(widget.doctorId));
    final reviewsAsync = ref.watch(doctorReviewsProvider(widget.doctorId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: doctorAsync.when(
        data: (doctor) => _buildContent(doctor, servicesAsync, reviewsAsync),
        loading: () => widget.initialDoctor != null
            ? _buildContent(widget.initialDoctor!, servicesAsync, reviewsAsync)
            : const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading doctor: $e')),
      ),
    );
  }

  Widget _buildContent(
    DoctorWithServicesModel doctor,
    AsyncValue<List<DentalServiceModel>> servicesAsync,
    AsyncValue<List<ReviewModel>> reviewsAsync,
  ) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: 'doctor-avatar-${doctor.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child:
                        doctor.avatarUrl != null && doctor.avatarUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: doctor.avatarUrl!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.surfaceVariant,
                              width: 120,
                              height: 120,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.textSecondary,
                                size: 40,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.surfaceVariant,
                              width: 120,
                              height: 120,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.textSecondary,
                                size: 40,
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.surfaceVariant,
                            width: 120,
                            height: 120,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text(doctor.fullName, style: AppTextStyles.headingLg),
                    const SizedBox(height: 4),
                    Text(doctor.specialty, style: AppTextStyles.bodyLg),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.starYellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '${doctor.rating.toStringAsFixed(1)} (${doctor.reviewCount} reviews)',
                            style: AppTextStyles.bodyMd,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: _buildActionBtn(Icons.call, 'Call', 0)),
                        Expanded(
                          child: _buildActionBtn(Icons.message, 'Message', 1),
                        ),
                        Expanded(
                          child: _buildActionBtn(
                            Icons.location_on,
                            'Location',
                            2,
                          ),
                        ),
                        Expanded(
                          child: _buildActionBtn(Icons.share, 'Share', 3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('About', style: AppTextStyles.headingSm),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Text(
                        doctor.bio ?? 'No bio provided.',
                        style: AppTextStyles.bodyMd,
                        maxLines: _isExpanded ? null : 3,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      ),
                    ),
                    if (!_isExpanded && (doctor.bio?.length ?? 0) > 100)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => setState(() => _isExpanded = true),
                          child: Text(
                            'Read more',
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.accentGreen,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Services', style: AppTextStyles.headingSm),
                    ),
                    const SizedBox(height: 16),
                    servicesAsync.when(
                      data: (docServices) {
                        if (docServices.isEmpty) {
                          return const Text('No services found.');
                        }
                        return Column(
                          children: docServices.map((service) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        service.iconUrl != null &&
                                            service.iconUrl!.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: service.iconUrl!,
                                            width: 24,
                                            height: 24,
                                            placeholder: (context, url) =>
                                                const Icon(
                                                  Icons.medical_services,
                                                  size: 24,
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.medical_services,
                                                      size: 24,
                                                    ),
                                          )
                                        : const Icon(
                                            Icons.medical_services,
                                            size: 24,
                                          ),
                                  ),
                                  const SizedBox(width: 12),
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
                                          service.description ?? '',
                                          style: AppTextStyles.bodySm,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'USD ${service.price.toInt()}',
                                    style: AppTextStyles.priceMd,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const Text('Error loading services'),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Reviews', style: AppTextStyles.headingSm),
                    ),
                    const SizedBox(height: 16),
                    reviewsAsync.when(
                      data: (reviews) {
                        if (reviews.isEmpty) {
                          return const Text('No reviews yet.');
                        }
                        return Column(
                          children: reviews.map((review) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage:
                                            review.profile?.avatarUrl != null
                                            ? CachedNetworkImageProvider(
                                                review.profile!.avatarUrl!,
                                              )
                                            : null,
                                        child: review.profile?.avatarUrl == null
                                            ? const Icon(Icons.person, size: 20)
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        review.profile?.fullName ?? 'Anonymous',
                                        style: AppTextStyles.labelSm,
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star,
                                            size: 14,
                                            color: index < review.rating
                                                ? AppColors.starYellow
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (review.comment != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      review.comment!,
                                      style: AppTextStyles.bodySm,
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const Text('Error loading reviews'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: AppButton(
                label: 'Book Appointment',
                onPressed: () {
                  ref.read(bookingProvider.notifier).reset();
                  ref.read(bookingProvider.notifier).selectDoctor(doctor);
                  context.push('/book/service');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, String label, int index) {
    final scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(0.2 + (index * 0.1), 1.0, curve: Curves.elasticOut),
      ),
    );
    return ScaleTransition(
      scale: scaleAnim,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.accentGreen),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelSm),
        ],
      ),
    );
  }
}
