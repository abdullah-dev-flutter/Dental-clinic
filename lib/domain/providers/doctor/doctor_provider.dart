import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/doctor/doctor_model.dart';
import '../../../data/models/upcoming_appointment_model.dart';
import '../../providers/repository_providers.dart';

final doctorProfileProvider = FutureProvider<DoctorModel?>((ref) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return null;

  return ref.read(doctorRepositoryProvider).fetchDoctorProfile(user.id);
});

final doctorAppointmentsProvider =
    FutureProvider.family<List<UpcomingAppointmentModel>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getAppointments(doctorId: doctorId);
});

final doctorPatientsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getDoctorPatients(doctorId);
});

final doctorPaymentsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getPayments(doctorId);
});

final doctorWeeklyAppointmentsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getWeeklyAppointments(doctorId);
});

final doctorTodayStatsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, doctorId) async {
  return ref.read(doctorRepositoryProvider).getTodayStats(doctorId);
});

final doctorMonthlyEarningsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getMonthlyEarnings(doctorId);
});

final doctorDashboardStatsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, doctorId) async {
  return ref.read(doctorRepositoryProvider).getDashboardStats(doctorId);
});

final doctorScheduleProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getSchedule(doctorId);
});

final doctorLeavesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, doctorId) {
  return ref.read(doctorRepositoryProvider).getLeaves(doctorId);
});

final doctorAppointmentProvider =
    FutureProvider.family<UpcomingAppointmentModel?, String>((ref, appointmentId) {
  return ref.read(doctorRepositoryProvider).getAppointmentById(appointmentId);
});
