import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dental_service_model.dart';
import '../../data/models/clinic_model.dart';
import 'repository_providers.dart';

final serviceListProvider = FutureProvider<List<DentalServiceModel>>((
  ref,
) async {
  final repo = ref.read(serviceRepositoryProvider);
  return repo.fetchActiveServices();
});

final clinicListProvider = FutureProvider<List<ClinicModel>>((ref) async {
  final repo = ref.read(serviceRepositoryProvider);
  return repo.fetchClinics();
});
