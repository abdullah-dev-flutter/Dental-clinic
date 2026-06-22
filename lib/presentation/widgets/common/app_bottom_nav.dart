import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/providers/auth_provider.dart';
import 'app_avatar.dart';

class AppBottomNav extends ConsumerWidget {
  final Widget child;
  const AppBottomNav({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    int currentIndex = 0;
    if (location.startsWith('/clinics-map')) currentIndex = 1;
    if (location.startsWith('/schedule')) currentIndex = 2;
    if (location.startsWith('/profile')) currentIndex = 3;

    final profileState = ref.watch(currentProfileProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.accentGreen,
          currentIndex: currentIndex,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/clinics-map');
                break;
              case 2:
                context.go('/schedule');
                break;
              case 3:
                context.go('/profile');
                break;
            }
          },
          items: [
            _buildNavItem(Icons.home, 'Home', 0, currentIndex),
            _buildNavItem(Icons.map_outlined, 'Clinics', 1, currentIndex),
            _buildNavItem(Icons.calendar_month, 'Schedule', 2, currentIndex),
            profileState.when(
              data: (profile) => BottomNavigationBarItem(
                icon: profile?.avatarUrl != null
                    ? AppAvatar(
                        url: profile!.avatarUrl!,
                        size: 32, // Increased size
                      )
                    : Icon(
                        Icons.person,
                        color: currentIndex == 3
                            ? AppColors.accentBlue
                            : AppColors.textSecondary,
                      ),
                label: 'Profile',
              ),
              loading: () => const BottomNavigationBarItem(
                icon: SizedBox(
                  width: 32, // Increased size
                  height: 32, // Increased size
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accentBlue,
                    ),
                  ),
                ),
                label: 'Profile',
              ),
              error: (err, stack) => BottomNavigationBarItem(
                icon: Icon(
                  Icons.error,
                  color: currentIndex == 3
                      ? AppColors.accentBlue
                      : AppColors.textSecondary,
                ),
                label: 'Profile',
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int itemIndex,
    int currentIndex,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: itemIndex == currentIndex
            ? AppColors.accentBlue
            : AppColors.textSecondary,
      ),
      label: label,
    );
  }
}
