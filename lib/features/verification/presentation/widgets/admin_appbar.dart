import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class AdminAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool isMobile;

  const AdminAppBar({super.key, required this.title, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      iconTheme: const IconThemeData(color: Colors.black87),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 18 : 24,
        ),
      ),
      actions: [
        if (!isMobile)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Row(
                children: [
                  const Icon(Icons.account_circle, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    user?.email ?? 'Admin',
                    style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
