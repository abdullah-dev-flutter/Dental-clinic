import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/providers/auth_provider.dart';
import '../../../widgets/common/app_button.dart';

class VerificationPendingScreen extends ConsumerWidget {
  const VerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pending_actions_outlined,
              size: 100,
              color: AppColors.accentBlue,
            ),
            const SizedBox(height: 32),
            Text(
              'Verification Pending',
              style: AppTextStyles.headingLg,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your application has been submitted and is waiting for KYC verification. This usually takes 24-48 hours. We will notify you once your account is approved.',
              style: AppTextStyles.bodyMd,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            AppButton(
              label: 'Logout',
              onPressed: () => ref.read(authProvider.notifier).logout(),
              color: AppColors.errorRed,
            ),
          ],
        ),
      ),
    );
  }
}
