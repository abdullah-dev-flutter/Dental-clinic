import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    bool isSuccess = true,
  }) {
    final bgColor = isError
        ? AppColors.errorRed
        : (isSuccess ? AppColors.accentGreen : AppColors.accentBlue);
    final icon = isError
        ? Icons.error_outline
        : (isSuccess ? Icons.check_circle_outline : Icons.info_outline);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.labelMd.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        elevation: 4,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, isSuccess: true, isError: false);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, isSuccess: false, isError: true);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, isSuccess: false, isError: false);
  }
}
