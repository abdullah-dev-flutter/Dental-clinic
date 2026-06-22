import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/supabase_client.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/appointment_repository.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/repositories/review_repository.dart';
import '../../data/repositories/doctor/doctor_repository.dart';
import '../../data/repositories/clinic_repository.dart';
import '../../data/repositories/nearby_clinic_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.read(supabaseClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(supabaseClientProvider));
});

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  return DoctorRepository(ref.read(supabaseClientProvider));
});

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepository(ref.read(supabaseClientProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.read(supabaseClientProvider));
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(ref.read(supabaseClientProvider));
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.read(supabaseClientProvider));
});

final clinicRepositoryProvider = Provider<ClinicRepository>((ref) {
  return ClinicRepository(ref.read(supabaseClientProvider));
});

final nearbyClinicRepositoryProvider = Provider<NearbyClinicRepository>((ref) {
  return NearbyClinicRepository(ref.read(supabaseClientProvider));
});
