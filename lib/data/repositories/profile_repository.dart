import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';
import '../../core/exceptions.dart';
import 'package:image_picker/image_picker.dart'; // Add this import

class ProfileRepository {
  final SupabaseClient _client;
  ProfileRepository(this._client);

  Future<ProfileModel> fetchProfile(String userId) async {
    return safeCall(() async {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return ProfileModel.fromJson(response);
    });
  }

  Future<void> markOnboardingDone(String userId) async {
    return safeCall(() async {
      await _client
          .from('profiles')
          .update({'onboarding_done': true})
          .eq('id', userId);
    });
  }

  Future<void> updateProfile({
    required String userId,
    String? fullName,
    String? phone,
    String? address,
    String? city,
    String? gender,
    DateTime? dateOfBirth,
  }) async {
    return safeCall(() async {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (phone != null) updates['phone'] = phone;
      if (address != null) updates['address'] = address;
      if (city != null) updates['city'] = city;
      if (gender != null) updates['gender'] = gender;
      if (dateOfBirth != null) {
        updates['date_of_birth'] = dateOfBirth.toIso8601String().split('T')[0];
      }

      await _client.from('profiles').update(updates).eq('id', userId);
    });
  }

  Future<String> uploadAvatar({
    required String userId,
    required XFile imageFile,
  }) async {
    return safeCall(() async {
      final ext = imageFile.path.split('.').last;
      final path = '$userId/profile.$ext';
      final bytes = await imageFile.readAsBytes();

      await _client.storage.from('avatars').uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: 'image/$ext',
            ),
          );

      final publicUrl = _client.storage.from('avatars').getPublicUrl(path);

      await _client
          .from('profiles')
          .update({'avatar_url': publicUrl})
          .eq('id', userId);
      return publicUrl;
    });
  }
}
