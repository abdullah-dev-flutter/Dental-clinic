import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/repository_providers.dart';
import '../../../domain/providers/home_providers.dart';
import '../../../data/models/notification_model.dart';
import 'package:intl/intl.dart';

final notificationsProvider = StreamProvider<List<NotificationModel>>((ref) {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return Stream.value([]);
  final repo = ref.read(notificationRepositoryProvider);
  return repo.watchNotifications(user.id);
});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () async {
              if (user != null) {
                await ref
                    .read(notificationRepositoryProvider)
                    .markAllRead(user.id);
                ref.invalidate(unreadNotificationCountProvider);
              }
            },
            style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
            child: Text(
              'Mark all as read',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.accentGreen,
              ),
            ),
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: AppColors.surfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text('No notifications', style: AppTextStyles.bodyMd),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: n.isRead
                      ? null
                      : Border.all(
                          color: AppColors.accentGreen.withValues(alpha: 0.3),
                        ),
                ),
                child: InkWell(
                  onTap: () async {
                    if (!n.isRead) {
                      await ref
                          .read(notificationRepositoryProvider)
                          .markNotificationRead(n.id);
                      ref.invalidate(unreadNotificationCountProvider);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _getNotificationColor(
                            n.type,
                          ).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getNotificationIcon(n.type),
                          color: _getNotificationColor(n.type),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(n.title, style: AppTextStyles.labelMd),
                                Text(
                                  _formatTime(n.createdAt),
                                  style: AppTextStyles.bodySm.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n.message,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'appointment_reminder':
        return Icons.alarm;
      case 'appointment_confirmed':
        return Icons.check_circle_outline;
      case 'appointment_cancelled':
        return Icons.cancel_outlined;
      case 'payment_received':
        return Icons.payment;
      default:
        return Icons.notifications_none;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'appointment_confirmed':
        return AppColors.accentGreen;
      case 'appointment_cancelled':
        return AppColors.errorRed;
      case 'payment_received':
        return AppColors.accentBlue;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('MMM dd').format(date);
  }
}
