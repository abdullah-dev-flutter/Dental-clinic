import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/upcoming_appointment_model.dart';
import 'repository_providers.dart';
import 'auth_provider.dart';

final upcomingAppointmentsProvider = FutureProvider<List<UpcomingAppointmentModel>>((ref) async {
  final profile = await ref.watch(currentProfileProvider.future);
  if (profile == null || profile.phone == null) return [];
  
  final repo = ref.read(appointmentRepositoryProvider);
  return repo.fetchUpcomingAppointments(profile.phone!);
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
