import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../domain/providers/auth_provider.dart';
import '../../../../domain/providers/repository_providers.dart';
import '../../../../presentation/widgets/common/app_button.dart';
import '../../../../presentation/widgets/common/app_text_field.dart';

class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.login(email: _emailCtrl.text.trim(), password: _passCtrl.text);

      // Verify role
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        final profileRepo = ref.read(profileRepositoryProvider);
        final profile = await profileRepo.fetchProfile(user.id);

        if (profile.role != 'admin') {
          await repo.logout();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Access Denied. Admin privileges required.'),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        } else {
          // Success, GoRouter will handle redirect based on role
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Lighter background for web admin
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Admin Portal',
                    style: AppTextStyles.headingLg.copyWith(color: AppColors.background),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Login to manage doctor verifications',
                    style: AppTextStyles.bodyMd.copyWith(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  hint: 'Admin Email',
                  controller: _emailCtrl,
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'Password',
                  controller: _passCtrl,
                  obscure: _obscure,
                  validator: Validators.password,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600]),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: 'Login as Admin',
                  isLoading: _isLoading,
                  onPressed: _handleLogin,
                  color: AppColors.accentBlue, // Admin specific primary color
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
