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

final expandedNotificationIdProvider = StateProvider<String?>((ref) => null);
final locallyMarkedReadProvider = StateProvider<Set<String>>((ref) => {});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final expandedId = ref.watch(expandedNotificationIdProvider);
    final locallyRead = ref.watch(locallyMarkedReadProvider);
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16),
          color: AppColors.surface.withOpacity(0.5),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              Text('NOTIFICATIONS', style: AppTextStyles.headingLg.copyWith(letterSpacing: 1.2, fontSize: 20)),
            ],
          ),
        ),
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
            padding: const EdgeInsets.all(24),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              final isExpanded = expandedId == n.id;
              final isRead = n.isRead || locallyRead.contains(n.id);

              return AnimatedContainer(
                key: ValueKey(n.id),
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        ref.read(expandedNotificationIdProvider.notifier).state = isExpanded ? null : n.id;
                        if (!isRead) {
                          ref.read(locallyMarkedReadProvider.notifier).update((state) => {...state, n.id});
                          await ref.read(notificationRepositoryProvider).markNotificationRead(n.id);
                          ref.invalidate(notificationsProvider);
                          ref.invalidate(unreadNotificationCountProvider);
                        }
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _getNotificationColor(n.type).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getNotificationIcon(n.type),
                                color: _getNotificationColor(n.type),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(n.title, style: AppTextStyles.labelMd.copyWith(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  AnimatedCrossFade(
                                    firstChild: Text(
                                      n.body,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                                    ),
                                    secondChild: Text(
                                      n.body,
                                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                                    ),
                                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _formatTime(n.createdAt),
                                    style: AppTextStyles.bodySm.copyWith(fontSize: 11, color: AppColors.textHint),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!isRead)
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.accentGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: 'Mark all',
                color: AppColors.accentGreen,
                onPressed: () async {
                  if (user != null) {
                    await ref.read(notificationRepositoryProvider).markAllRead(user.id);
                    ref.read(locallyMarkedReadProvider.notifier).state = {};
                    ref.invalidate(notificationsProvider);
                    ref.invalidate(unreadNotificationCountProvider);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ActionButton(
                label: 'Clear Screen',
                color: AppColors.errorRed,
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.surface,
                      title: Text('Clear Notifications', style: AppTextStyles.labelMd.copyWith(fontWeight: FontWeight.bold)),
                      content: Text('Are you sure you want to delete all notifications?', style: AppTextStyles.bodyMd),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel', style: AppTextStyles.labelSm),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Delete', style: AppTextStyles.labelSm.copyWith(color: AppColors.errorRed)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && user != null) {
                    await ref.read(notificationRepositoryProvider).deleteAllNotifications(user.id);
                    ref.read(locallyMarkedReadProvider.notifier).state = {};
                    ref.invalidate(notificationsProvider);
                    ref.invalidate(unreadNotificationCountProvider);
                  }
                },
              ),
            ),
          ],
        ),
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

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
