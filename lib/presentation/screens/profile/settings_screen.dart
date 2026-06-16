import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchItem('Notifications', true),
          _buildSwitchItem('Email Updates', false),
          const SizedBox(height: 16),
          _buildNavItem('Language', 'English'),
          _buildNavItem('Theme', 'Dark'),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: SwitchListTile(
            title: Text(title, style: AppTextStyles.labelMd),
            value: value,
            onChanged: (v) {},
            activeThumbColor: AppColors.accentGreen,
            activeTrackColor: AppColors.accentGreen.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ListTile(
            title: Text(title, style: AppTextStyles.labelMd),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value, style: AppTextStyles.bodySm),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
