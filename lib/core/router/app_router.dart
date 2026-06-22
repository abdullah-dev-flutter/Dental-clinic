import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/otp_verification_screen.dart';
import '../../presentation/screens/auth/reset_password_screen.dart';
import '../../presentation/screens/shell/shell_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
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
import '../../presentation/screens/doctor/auth/pending_verification_screen.dart';
import '../../presentation/screens/doctor/auth/rejected_verification_screen.dart';
import '../../presentation/screens/doctor/dashboard/doctor_dashboard_screen.dart';
import '../../presentation/screens/clinic_location_picker_screen.dart';
import '../../presentation/screens/doctor/auth/doctor_signup_step2.dart';
import '../../presentation/screens/doctor/auth/doctor_signup_step3.dart';
import '../../presentation/screens/doctor/shell/doctor_shell_screen.dart';
import '../../presentation/screens/doctor/appointments/doctor_appointments_screen.dart';
import '../../presentation/screens/doctor/appointments/doctor_appointment_detail_screen.dart';
import '../../presentation/screens/doctor/schedule/doctor_schedule_screen.dart';
import '../../presentation/screens/doctor/patients/doctor_patients_screen.dart';
import '../../presentation/screens/doctor/profile/doctor_profile_screen.dart';
import '../../features/auth/presentation/admin_login_screen.dart';
import '../../features/verification/presentation/dashboard_screen.dart';
import '../../features/verification/presentation/doctor_detail_screen.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/doctor/doctor_provider.dart';


final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);
final GlobalKey<NavigatorState> _doctorShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'doctorShell',
);

class RouterNotifier extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  RouterNotifier(Ref ref) {
    _subscription = Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      notifyListeners();
    });

    ref.listen(currentProfileProvider, (_, __) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    refreshListenable: notifier,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = Supabase.instance.client.auth.currentUser != null;
      final isSplashRoute = state.matchedLocation == '/splash';
      final isAuthRoute =
          state.matchedLocation == '/auth' ||
          state.matchedLocation == '/auth/forgot-password' ||
          state.matchedLocation == '/auth/otp' ||
          state.matchedLocation == '/onboarding';
      final isResetRoute = state.matchedLocation == '/auth/reset-password';
      final isAdminLoginRoute = state.matchedLocation == '/admin/login';

      if (isSplashRoute) return null;
      if (!isLoggedIn && !isAuthRoute && !isResetRoute && !isAdminLoginRoute) {
        if (state.matchedLocation.startsWith('/admin')) {
          return '/admin/login';
        }
        return '/auth';
      }
      
      if (isLoggedIn) {
        final profileAsync = ref.read(currentProfileProvider);
        
        return profileAsync.when(
          data: (profile) {
            if (profile == null) return null;

            final user = Supabase.instance.client.auth.currentUser;
            final metadataRole = user?.userMetadata?['role'] as String?;
            final dbRole = profile.role;

            String role;
            if (dbRole == 'admin' || metadataRole == 'admin') {
              role = 'admin';
            } else if (metadataRole == 'doctor' || dbRole == 'doctor') {
              role = 'doctor';
            } else {
              role = 'patient';
            }

            if (role == 'admin') {
              if (isAuthRoute || isAdminLoginRoute) return '/admin/dashboard';
              if (!state.matchedLocation.startsWith('/admin')) return '/admin/dashboard';
              return null;
            } else if (role == 'patient') {
              if (isAuthRoute || isAdminLoginRoute) return '/home';
              if (state.matchedLocation.startsWith('/admin')) return '/home';
              return null;
            } else if (role == 'doctor') {
              if (isAdminLoginRoute || state.matchedLocation.startsWith('/admin')) return '/doctor/dashboard';
              final doctorAsync = ref.read(doctorProfileProvider);
              return doctorAsync.when(
                data: (doctor) {
                  // If doctor record doesn't exist yet, they are in signup flow
                  if (doctor == null) {
                    if (state.matchedLocation.startsWith('/doctor/signup')) return null;
                    return '/doctor/signup/step2';
                  }

                  if (doctor.status == 'pending') {
                    if (state.matchedLocation == '/doctor/pending') return null;
                    return '/doctor/pending';
                  }
                  if (doctor.status == 'rejected') {
                    if (state.matchedLocation == '/doctor/rejected') return null;
                    return '/doctor/rejected';
                  }
                  if (doctor.status == 'approved') {
                    if (isAuthRoute || state.matchedLocation.startsWith('/doctor/signup')) return '/doctor/dashboard';
                    return null;
                  }
                  return null;
                },
                loading: () => null,
                error: (_, __) => null,
              );
            }
            return null;
          },
          loading: () => null,
          error: (_, __) => null,
        );
      }

      return null;
    },
routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
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
              final email = state.extra as String?;
              return ResetPasswordScreen(email: email);
            },
          ),
        ],
      ),
      // Admin Routes
      GoRoute(
        path: '/admin/login',
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/doctor/detail',
        builder: (context, state) => const DoctorDetailScreen(),
      ),
      // Doctor Routes
      GoRoute(
        path: '/doctor/pending',
        builder: (context, state) => const VerificationPendingScreen(),
      ),
      GoRoute(
        path: '/doctor/rejected',
        builder: (context, state) => const RejectedVerificationScreen(),
      ),
      GoRoute(
        path: '/doctor/signup/step2',
        builder: (context, state) => const DoctorSignupStep2(),
      ),
      GoRoute(
        path: '/doctor/signup/step3',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            child: DoctorSignupStep3(doctorData: data),
            transitionsBuilder: (context, anim, secAnim, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/doctor/signup/location-picker',
        builder: (context, state) => const ClinicLocationPickerScreen(),
      ),
      ShellRoute(
        navigatorKey: _doctorShellNavigatorKey,
        builder: (context, state, child) => DoctorShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/doctor/dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(child: DoctorDashboardScreen()),
          ),
          GoRoute(
            path: '/doctor/appointments',
            pageBuilder: (context, state) => const NoTransitionPage(child: DoctorAppointmentsScreen()),
          ),
          GoRoute(
            path: '/doctor/schedule',
            pageBuilder: (context, state) => const NoTransitionPage(child: DoctorScheduleScreen()),
          ),
          GoRoute(
            path: '/doctor/patients',
            pageBuilder: (context, state) => const NoTransitionPage(child: DoctorPatientsScreen()),
          ),
          GoRoute(
            path: '/doctor/profile',
            pageBuilder: (context, state) => const NoTransitionPage(child: DoctorProfileScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/doctor/appointment/:id',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CustomTransitionPage(
            child: DoctorAppointmentDetailScreen(appointmentId: id),
            transitionsBuilder: (context, anim, secAnim, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              );
            },
          );
        },
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
            path: '/clinics-map',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MapClinicsScreen()),
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
        path: '/clinics/detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ClinicDetailScreen(),
      ),
    ],
  );
});
