import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';

class ReviewRepository {
  final SupabaseClient _client;
  ReviewRepository(this._client);

  Future<void> submitReview({
    required String patientId,
    required String doctorId,
    required String appointmentId,
    required int rating,
    String? comment,
  }) async {
    return safeCall(() async {
      await _client.from('reviews').insert({
        'patient_id': patientId,
        'doctor_id': doctorId,
        'appointment_id': appointmentId,
        'rating': rating,
        'comment': comment,
      });
      
      await _client
          .from('appointments')
          .update({'status': 'completed'})
          .eq('id', appointmentId);
    });
  }
}
