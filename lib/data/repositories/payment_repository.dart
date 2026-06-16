import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/saved_payment_method_model.dart';

class PaymentRepository {
  final SupabaseClient _client;
  PaymentRepository(this._client);

  Future<List<SavedPaymentMethodModel>> fetchSavedPaymentMethods(String patientId) async {
    return safeCall(() async {
      final response = await _client
          .from('saved_payment_methods')
          .select()
          .eq('patient_id', patientId)
          .order('is_default', ascending: false);
      return (response as List).map((e) => SavedPaymentMethodModel.fromJson(e)).toList();
    });
  }

  Future<void> addPaymentMethod({
    required String patientId,
    required String methodType,
    required String label,
    bool isDefault = false,
  }) async {
    return safeCall(() async {
      if (isDefault) {
        await _client
            .from('saved_payment_methods')
            .update({'is_default': false})
            .eq('patient_id', patientId);
      }
      await _client.from('saved_payment_methods').insert({
        'patient_id': patientId,
        'method_type': methodType,
        'label': label,
        'is_default': isDefault,
      });
    });
  }

  Future<void> deletePaymentMethod(String methodId) async {
    return safeCall(() async {
      await _client.from('saved_payment_methods').delete().eq('id', methodId);
    });
  }
}
