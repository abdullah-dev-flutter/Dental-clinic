import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpCtrl = TextEditingController();

  Future<void> _handleVerify() async {
    if (_otpCtrl.text.length == 6) {
      await ref.read(authProvider.notifier).verifyOtp(widget.email, _otpCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: AppColors.errorRed,
          ),
        );
      } else if (next.hasValue && !next.isLoading && previous?.isLoading == true) {
        context.push('/auth/reset-password', extra: widget.email);
      }
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verification', style: AppTextStyles.headingLg),
            const SizedBox(height: 8),
            Text(
              'Enter the 6-digit code sent to ${widget.email}',
              style: AppTextStyles.bodyMd,
            ),
            const SizedBox(height: 32),
            AppTextField(
              hint: '000000',
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'Verify',
              isLoading: authState.isLoading,
              onPressed: _handleVerify,
            ),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () => ref.read(authProvider.notifier).sendResetPasswordLink(widget.email),
                child: Text('Resend Link', style: AppTextStyles.labelMd.copyWith(color: AppColors.accentGreen)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
