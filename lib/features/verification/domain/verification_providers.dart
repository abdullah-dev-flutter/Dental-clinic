import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/supabase_client.dart';
import '../data/verification_repository.dart';
import 'doctor_verification_model.dart';

final verificationRepositoryProvider = Provider<VerificationRepository>((ref) {
  return VerificationRepository(ref.read(supabaseClientProvider));
});

final pendingDoctorsProvider = FutureProvider<List<DoctorVerificationModel>>((ref) {
  return ref.read(verificationRepositoryProvider).fetchDoctorsByStatus('pending');
});

final approvedDoctorsProvider = FutureProvider<List<DoctorVerificationModel>>((ref) {
  return ref.read(verificationRepositoryProvider).fetchDoctorsByStatus('approved');
});

final rejectedDoctorsProvider = FutureProvider<List<DoctorVerificationModel>>((ref) {
  return ref.read(verificationRepositoryProvider).fetchDoctorsByStatus('rejected');
});

final pendingCountProvider = StreamProvider<int>((ref) {
  return Supabase.instance.client
      .from('doctors')
      .stream(primaryKey: ['id'])
      .eq('status', 'pending')
      .map((data) => data.length);
});

// A provider to hold the currently selected doctor for the detail screen
final selectedDoctorProvider = StateProvider<DoctorVerificationModel?>((ref) => null);
