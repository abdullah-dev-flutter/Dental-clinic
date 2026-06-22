import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/providers/auth_provider.dart';

class AdminSidebar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Icon(Icons.local_hospital, color: AppColors.accentBlue, size: 32),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 16),
          _buildNavItem(0, 'Dashboard', Icons.dashboard),
          _buildNavItem(1, 'Pending', Icons.pending_actions),
          _buildNavItem(2, 'Approved', Icons.check_circle_outline),
          _buildNavItem(3, 'Rejected', Icons.cancel_outlined),
          const Spacer(),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.errorRed),
            title: const Text('Logout', style: TextStyle(color: AppColors.errorRed)),
            onTap: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon) {
    final isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.accentBlue : Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.accentBlue : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.accentBlue.withOpacity(0.1),
      onTap: () => onItemSelected(index),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
