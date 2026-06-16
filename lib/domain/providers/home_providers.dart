import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/dental_service_model.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/upcoming_appointment_model.dart';
import 'repository_providers.dart';

final dentalServicesProvider = FutureProvider<List<DentalServiceModel>>((ref) async {
  final repo = ref.read(serviceRepositoryProvider);
  return repo.fetchActiveServices();
});

final clinicsProvider = FutureProvider<List<ClinicModel>>((ref) async {
  final repo = ref.read(serviceRepositoryProvider);
  return repo.fetchClinics();
});

final upcomingAppointmentsProvider = FutureProvider<List<UpcomingAppointmentModel>>((ref) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return [];
  final repo = ref.read(appointmentRepositoryProvider);
  return repo.fetchUpcomingAppointments(user.id);
});

final unreadNotificationCountProvider = StreamProvider<int>((ref) {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return Stream.value(0);
  
  return Supabase.instance.client
      .from('notifications')
      .stream(primaryKey: ['id'])
      .eq('patient_id', user.id)
      .map((rows) => rows.where((r) => r['is_read'] == false).length);
});
