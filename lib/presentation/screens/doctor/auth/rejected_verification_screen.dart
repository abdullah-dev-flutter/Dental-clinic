import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/providers/auth_provider.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../widgets/common/app_button.dart';

class RejectedVerificationScreen extends ConsumerWidget {
  const RejectedVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorProfile = ref.watch(doctorProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: AppColors.errorRed,
            ),
            const SizedBox(height: 32),
            Text(
              'Application Rejected',
              style: AppTextStyles.headingLg,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            doctorProfile.when(
              data: (doctor) => Text(
                'Reason: ${doctor?.rejectionReason ?? "Your application did not meet our requirements."}',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.errorRed),
                textAlign: TextAlign.center,
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => const Text('Error loading rejection reason'),
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
