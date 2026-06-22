import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/upcoming_appointment_model.dart';
import '../../data/repositories/appointment_repository.dart';
import 'repository_providers.dart';
import 'auth_provider.dart';

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
  final Ref _ref;

  AppointmentNotifier(this._repository, this._ref) : super(AppointmentState()) {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    final profile = await _ref.read(currentProfileProvider.future);
    if (profile == null || profile.phone == null) return;

    final phone = profile.phone!;

    state = state.copyWith(isLoading: true);
    try {
      final upcoming = await _repository.fetchAppointmentsByStatus(
        patientPhone: phone,
        status: 'upcoming',
      );
      final completed = await _repository.fetchAppointmentsByStatus(
        patientPhone: phone,
        status: 'completed',
      );
      final cancelled = await _repository.fetchAppointmentsByStatus(
        patientPhone: phone,
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
  return AppointmentNotifier(ref.read(appointmentRepositoryProvider), ref);
});
