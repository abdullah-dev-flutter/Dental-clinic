import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/app_snackbar.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _obscure = true;

  Future<void> _handleReset() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).updatePassword(_passCtrl.text);
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
        AppSnackBar.success(context, 'Password reset successfully!');
        context.go('/auth');
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reset Password', style: AppTextStyles.headingLg),
              const SizedBox(height: 8),
              Text(
                'Create a new password for your account.',
                style: AppTextStyles.bodyMd,
              ),
              const SizedBox(height: 32),
              AppTextField(
                hint: 'New Password',
                controller: _passCtrl,
                obscure: _obscure,
                validator: Validators.password,
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: AppColors.textSecondary),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'Confirm New Password',
                controller: _confirmPassCtrl,
                obscure: _obscure,
                validator: (v) => Validators.confirmPassword(v, _passCtrl.text),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Reset Password',
                isLoading: authState.isLoading,
                onPressed: _handleReset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
