import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../../widgets/common/app_button.dart';

class ConfirmationScreen extends ConsumerStatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  ConsumerState<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends ConsumerState<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _arcAnim;
  late Animation<double> _checkFade;
  late Animation<double> _pulseScale;
  late Animation<double> _pulseOpacity;
  late Animation<Offset> _cardSlide;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _arcAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _checkFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
      ),
    );

    _pulseScale = Tween<double>(begin: 1.0, end: 1.8).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );
    _pulseOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
          ),
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
    final bookingState = ref.read(
      bookingProvider,
    ); // Use read since we don't expect changes here

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Animation
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseScale.value,
                          child: Opacity(
                            opacity: _pulseOpacity.value,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.accentGreen,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _arcAnim,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _ArcPainter(_arcAnim.value),
                          size: const Size(80, 80),
                        );
                      },
                    ),
                    FadeTransition(
                      opacity: _checkFade,
                      child: const Icon(
                        Icons.check,
                        color: AppColors.accentGreen,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _checkFade,
                child: Column(
                  children: [
                    Text('Appointment Booked!', style: AppTextStyles.headingLg),
                    const SizedBox(height: 8),
                    Text(
                      'Your appointment has been successfully confirmed.',
                      style: AppTextStyles.bodyMd,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SlideTransition(
                position: _cardSlide,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accentBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.medical_services,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookingState.selectedService?.name ?? '',
                                  style: AppTextStyles.labelMd,
                                ),
                                Text(
                                  bookingState.selectedDoctor?.fullName ?? '',
                                  style: AppTextStyles.bodySm,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${bookingState.selectedDate?.formattedDate} • ${bookingState.selectedSlot?.start ?? ""}',
                            style: AppTextStyles.bodySm,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Greenwich Village, 123 Main Street, New York',
                              style: AppTextStyles.bodySm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SlideTransition(
                position: _cardSlide,
                child: Column(
                  children: [
                    AppButton(
                      label: 'View My Schedule',
                      onPressed: () {
                        ref.read(scheduleTabProvider.notifier).state =
                            1; // Upcoming
                        context.go('/schedule');
                      },
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Book Another',
                      isOutlined: true,
                      onPressed: () => context.go('/doctors'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentGreen
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(
      rect,
      -1.5708,
      6.2832 * progress,
      false,
      paint,
    ); // -pi/2 to draw from top
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
