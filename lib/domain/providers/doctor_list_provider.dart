import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/doctor_with_services_model.dart';
import '../../data/models/dental_service_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/doctor_schedule_model.dart';
import 'repository_providers.dart';

class DoctorSearchState {
  final String specialty;
  final String query;

  const DoctorSearchState({this.specialty = 'all', this.query = ''});

  DoctorSearchState copyWith({String? specialty, String? query}) {
    return DoctorSearchState(
      specialty: specialty ?? this.specialty,
      query: query ?? this.query,
    );
  }
}

class DoctorSearchNotifier extends StateNotifier<DoctorSearchState> {
  DoctorSearchNotifier() : super(const DoctorSearchState());

  void setSpecialty(String specialty) {
    state = state.copyWith(specialty: specialty);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }
}

final doctorSearchProvider =
    StateNotifierProvider<DoctorSearchNotifier, DoctorSearchState>((ref) {
      return DoctorSearchNotifier();
    });

final doctorListProvider = FutureProvider<List<DoctorWithServicesModel>>((
  ref,
) async {
  final searchState = ref.watch(doctorSearchProvider);
  final repo = ref.read(doctorRepositoryProvider);

  return repo.fetchDoctorsWithServices(
    specialty: searchState.specialty,
    searchQuery: searchState.query,
  );
});

final doctorByIdProvider =
    FutureProvider.family<DoctorWithServicesModel, String>((ref, id) async {
      final repo = ref.read(doctorRepositoryProvider);
      return repo.fetchDoctorById(id);
    });

final doctorServicesProvider =
    FutureProvider.family<List<DentalServiceModel>, String>((ref, id) async {
      final repo = ref.read(doctorRepositoryProvider);
      return repo.fetchDoctorServices(id);
    });

final doctorReviewsProvider = FutureProvider.family<List<ReviewModel>, String>((
  ref,
  id,
) async {
  final repo = ref.read(doctorRepositoryProvider);
  return repo.fetchDoctorReviews(id);
});

final doctorScheduleProvider =
    FutureProvider.family<List<DoctorScheduleModel>, String>((ref, id) async {
      final repo = ref.read(doctorRepositoryProvider);
      return repo.fetchDoctorSchedule(id);
    });
