import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final SupabaseClient _client;
  NotificationRepository(this._client);

  Future<int> getUnreadNotificationCount(String patientId) async {
    return safeCall(() async {
      final response = await _client.rpc(
        'unread_notification_count',
        params: {'p_patient_id': patientId},
      );
      return response as int;
    });
  }

  Stream<List<NotificationModel>> watchNotifications(String patientId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('patient_id', patientId)
        .order('created_at', ascending: false)
        .map((data) => data.map((e) => NotificationModel.fromJson(e)).toList());
  }

  Future<void> markNotificationRead(String notificationId) async {
    return safeCall(() async {
      await _client
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
    });
  }

  Future<void> markAllRead(String patientId) async {
    return safeCall(() async {
      await _client.rpc(
        'mark_all_notifications_read',
        params: {'p_patient_id': patientId},
      );
    });
  }

  Future<void> deleteAllNotifications(String patientId) async {
    return safeCall(() async {
      await _client.rpc(
        'delete_all_notifications',
        params: {'p_patient_id': patientId},
      );
    });
  }
}