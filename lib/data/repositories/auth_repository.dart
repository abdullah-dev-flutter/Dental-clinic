import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';

class AuthRepository {
  final SupabaseClient _client;
  AuthRepository(this._client);

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    return safeCall(() async {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
        },
      );
      return response;
    });
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> logout() async {
    return safeCall(() async {
      await _client.auth.signOut();
    });
  }

  Future<void> sendOtp(String email) async {
    return safeCall(() async {
      await _client.auth.resetPasswordForEmail(email);
    });
  }

  Future<void> verifyOtp(String email, String otp) async {
    return safeCall(() async {
      await _client.auth.verifyOTP(
        type: OtpType.recovery,
        email: email,
        token: otp,
      );
    });
  }

  Future<void> updatePassword(String newPassword) async {
    return safeCall(() async {
      await _client.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    });
  }
}
