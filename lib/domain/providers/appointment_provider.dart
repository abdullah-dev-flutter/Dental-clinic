import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/upcoming_appointment_model.dart';
import '../../data/repositories/appointment_repository.dart';
import 'repository_providers.dart';

class AppointmentState {
  final List<UpcomingAppointmentModel> upcoming;
  final List<UpcomingAppointmentModel> completed;
  final List<UpcomingAppointmentModel> cancelled;
  final bool isLoading;

  AppointmentState({
    this.upcoming = const [],
    this.completed = const [],
    this.cancelled = const [],
    this.isLoading = false,
  });

  AppointmentState copyWith({
    List<UpcomingAppointmentModel>? upcoming,
    List<UpcomingAppointmentModel>? completed,
    List<UpcomingAppointmentModel>? cancelled,
    bool? isLoading,
  }) {
    return AppointmentState(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final AppointmentRepository _repository;

  AppointmentNotifier(this._repository) : super(AppointmentState()) {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final upcoming = await _repository.fetchAppointmentsByStatus(
        patientId: user.id,
        status: 'upcoming',
      );
      final completed = await _repository.fetchAppointmentsByStatus(
        patientId: user.id,
        status: 'completed',
      );
      final cancelled = await _repository.fetchAppointmentsByStatus(
        patientId: user.id,
        status: 'cancelled',
      );
      
      state = state.copyWith(
        upcoming: upcoming,
        completed: completed,
        cancelled: cancelled,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> cancelAppointment(String id) async {
    try {
      await _repository.cancelAppointment(id);
      await loadAppointments();
    } catch (e) {
      // Handle error
    }
  }
}

final appointmentProvider = StateNotifierProvider<AppointmentNotifier, AppointmentState>((ref) {
  return AppointmentNotifier(ref.read(appointmentRepositoryProvider));
});
