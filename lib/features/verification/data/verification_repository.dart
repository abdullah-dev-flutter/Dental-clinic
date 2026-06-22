import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/exceptions.dart';
import '../domain/doctor_verification_model.dart';

class VerificationRepository {
  final SupabaseClient _client;
  VerificationRepository(this._client);

  Future<List<DoctorVerificationModel>> fetchDoctorsByStatus(String status) async {
    return safeCall(() async {
      // We need to fetch from doctors and join with doctor_verifications
      // Using Supabase foreign key join syntax
      final response = await _client
          .from('doctors')
          .select('''
            *,
            doctor_verifications(pmdc_license_url, degree_url, cnic_url)
          ''')
          .eq('status', status)
          .order('created_at', ascending: false);

      return (response as List).map((row) {
        final verifications = row['doctor_verifications'] as List?;
        final docs = (verifications != null && verifications.isNotEmpty) ? verifications.first : {};
        
        return DoctorVerificationModel.fromJson({
          ...row,
          'pmdc_license_url': docs['pmdc_license_url'],
          'degree_url': docs['degree_url'],
          'cnic_url': docs['cnic_url'],
        });
      }).toList();
    });
  }

  Future<void> approveDoctor(String doctorId, String userId) async {
    return safeCall(() async {
      await _client.rpc(
        'approve_doctor',
        params: {
          'p_doctor_id': doctorId,
          'p_user_id': userId,
        },
      );
    });
  }

  Future<void> rejectDoctor(String doctorId, String reason) async {
    return safeCall(() async {
      await _client.rpc(
        'reject_doctor',
        params: {
          'p_doctor_id': doctorId,
          'p_reason': reason,
        },
      );
    });
  }

  Future<int> getPendingCount() async {
    return safeCall(() async {
      final response = await _client.rpc('get_pending_count');
      return response as int;
    });
  }

  Future<String?> getSignedUrl(String? path) async {
    if (path == null || path.isEmpty) return null;
    
    // If it's already a full HTTP URL (e.g. from an old public bucket upload), just return it
    if (path.startsWith('http')) return path;

    return safeCall(() async {
      final response = await _client.storage
          .from('doctor-documents')
          .createSignedUrl(path, 60 * 60); // Valid for 1 hour
      return response;
    });
  }
}
