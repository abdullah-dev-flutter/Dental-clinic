import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/app_button.dart';
import '../../../domain/providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _animController;
  late Animation<Offset> _btnSlide;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboard1.png',
      'title': 'Your smile is our priority',
      'description':
          'Book appointments, consult doctors and keep your teeth healthy.',
    },
    {
      'image': 'assets/images/onboard2.jpeg',
      'title': 'Easy Scheduling',
      'description':
          'Pick your preferred date and time for your dental checkup.',
    },
    {
      'image': 'assets/images/onboard3.png',
      'title': 'Quality Treatment',
      'description': 'Experience the best dental care with our expert doctors.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _btnSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animController,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOutBack),
          ),
        );

    _animController.forward();

    // Add listener to rebuild when scrolling
    _pageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.removeListener(() => setState(() {}));
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) => _buildSlide(
              index,
              _onboardingData[index]['image']!,
              _onboardingData[index]['title']!,
              _onboardingData[index]['description']!,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.accentGreen
                            : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                SlideTransition(
                  position: _btnSlide,
                  child: Column(
                    children: [
                      AppButton(
                        label: _currentPage == _onboardingData.length - 1
                            ? 'Get Started'
                            : 'Next',
                        onPressed: () {
                          if (_currentPage < _onboardingData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            final user =
                                Supabase.instance.client.auth.currentUser;
                            if (user != null) {
                              ref.read(onboardingProvider(user.id));
                            }
                            context.go('/auth');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(
    int index,
    String image,
    String title,
    String description,
  ) {
    double offset = 0.0;
    if (_pageController.position.haveDimensions) {
      offset = _pageController.page! - index;
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Transform.scale(
            scale: 1.0 + (offset.abs() * 0.1),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Transform.translate(
              offset: Offset(0, offset * 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.headingLg.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 180,
                  ), // Space to sit above the dots and buttons
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
