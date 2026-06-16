import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem(Icons.question_answer_outlined, 'FAQs'),
          _buildItem(Icons.chat_bubble_outline, 'Contact Us'),
          _buildItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildItem(Icons.description_outlined, 'Terms of Service'),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title) {
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
            leading: Icon(icon, color: AppColors.accentBlue),
            title: Text(title, style: AppTextStyles.labelMd),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
