import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/otp_verification_screen.dart';
import '../../presentation/screens/auth/reset_password_screen.dart';
import '../../presentation/screens/shell/shell_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/services/services_screen.dart';
import '../../presentation/screens/doctors/doctors_screen.dart';
import '../../presentation/screens/doctors/doctor_profile_screen.dart';
import '../../presentation/screens/booking/book_service_screen.dart';
import '../../presentation/screens/booking/book_datetime_screen.dart';
import '../../presentation/screens/booking/confirmation_screen.dart';
import '../../presentation/screens/booking/payment_screen.dart';
import '../../presentation/screens/schedule/schedule_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/personal_details_screen.dart';
import '../../presentation/screens/profile/appointment_history_screen.dart';
import '../../presentation/screens/profile/payment_methods_screen.dart';
import '../../presentation/screens/profile/help_support_screen.dart';
import '../../presentation/screens/profile/settings_screen.dart';
import '../../presentation/screens/profile/notifications_screen.dart';
import '../../presentation/screens/nearby_clinics_screen.dart';
import '../../presentation/screens/map_clinics_screen.dart';
import '../../presentation/screens/clinic_detail_screen.dart';
import '../../data/models/doctor_with_services_model.dart';


final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  );
  ref.onDispose(refreshListenable.dispose);

  return GoRouter(
    refreshListenable: refreshListenable,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/onboarding',
    redirect: (context, state) {
      final isLoggedIn = Supabase.instance.client.auth.currentUser != null;
      final isAuthRoute =
          state.matchedLocation == '/auth' ||
          state.matchedLocation.startsWith('/auth/') ||
          state.matchedLocation.startsWith('/onboarding');

      if (!isLoggedIn && !isAuthRoute) return '/auth';
      if (isLoggedIn && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const AuthScreen(),
          transitionsBuilder: (context, anim, secAnim, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
        routes: [
          GoRoute(
            path: 'forgot-password',
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: 'otp',
            builder: (context, state) {
              final email = state.extra as String;
              return OtpVerificationScreen(email: email);
            },
          ),
          GoRoute(
            path: 'reset-password',
            builder: (context, state) {
              final email = state.extra as String;
              return ResetPasswordScreen(email: email);
            },
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/services',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ServicesScreen()),
          ),
          GoRoute(
            path: '/doctors',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DoctorsScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
          GoRoute(
            path: '/schedule',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ScheduleScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/doctor/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final doctorId = state.pathParameters['id']!;
          final initialDoctor = state.extra is Map<String, dynamic>
              ? DoctorWithServicesModel.fromJson(
                  state.extra as Map<String, dynamic>,
                )
              : state.extra as DoctorWithServicesModel?;
          return CustomTransitionPage(
            child: DoctorProfileScreen(
              doctorId: doctorId,
              initialDoctor: initialDoctor,
            ),
            transitionsBuilder: (context, anim, secAnim, child) {
              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: anim, curve: Curves.easeInOut),
                    ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/book/service',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const BookServiceScreen(),
          transitionsBuilder: (context, anim, secAnim, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/book/datetime',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const BookDateTimeScreen(),
          transitionsBuilder: (context, anim, secAnim, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/payment',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const PaymentScreen(),
          transitionsBuilder: (context, anim, secAnim, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/book/confirm',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ConfirmationScreen(),
          transitionsBuilder: (context, anim, secAnim, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            );
          },
        ),
      ),
      GoRoute(
        path: '/profile/details',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PersonalDetailsScreen(),
      ),
      GoRoute(
        path: '/profile/history',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AppointmentHistoryScreen(),
      ),
      GoRoute(
        path: '/profile/payments',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: '/profile/help',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/profile/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/nearby-clinics',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NearbyClinicsScreen(),
      ),
      GoRoute(
        path: '/clinics-map',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MapClinicsScreen(),
      ),
      GoRoute(
        path: '/clinics/detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ClinicDetailScreen(),
      ),
    ],
  );
});
