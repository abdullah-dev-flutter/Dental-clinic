import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

enum AuthMode { login, signup }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> with SingleTickerProviderStateMixin {
  AuthMode _mode = AuthMode.login;
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _agreed = false;

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authProvider.notifier);
      if (_mode == AuthMode.login) {
        await authNotifier.login(email: _emailCtrl.text.trim(), password: _passCtrl.text);
      } else {
        if (!_agreed) return;
        await authNotifier.register(
          email: _emailCtrl.text.trim(),
          password: _passCtrl.text,
          fullName: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
        );
        // On successful register, Supabase automatically logs in the user, 
        // which will trigger the GoRouter redirect.
      }
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
      }
    });

    final authState = ref.watch(authProvider);
    final isLogin = _mode == AuthMode.login;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(isLogin ? 'Welcome back' : 'Create account', style: AppTextStyles.headingLg),
                const SizedBox(height: 8),
                Text(isLogin ? 'Glad to see you again' : 'Let\'s get started', style: AppTextStyles.bodyMd),
                const SizedBox(height: 32),
                _buildToggle(),
                const SizedBox(height: 32),
                if (!isLogin) ...[
                  AppTextField(hint: 'Full Name', controller: _nameCtrl, validator: (v) => Validators.required(v, 'Name')),
                  const SizedBox(height: 16),
                ],
                AppTextField(hint: 'Email', controller: _emailCtrl, validator: Validators.email),
                const SizedBox(height: 16),
                if (!isLogin) ...[
                  AppTextField(hint: 'Phone Number', controller: _phoneCtrl, keyboardType: TextInputType.phone, validator: Validators.phone),
                  const SizedBox(height: 16),
                ],
                AppTextField(
                  hint: 'Password',
                  controller: _passCtrl,
                  obscure: _obscure,
                  validator: Validators.password,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: AppColors.textSecondary),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                if (isLogin) ...[
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push('/auth/forgot-password'),
                      child: Text('Forgot password?', style: AppTextStyles.bodyMd),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        activeColor: AppColors.accentGreen,
                      ),
                      Expanded(child: Text('I agree to Terms & Conditions', style: AppTextStyles.bodySm)),
                    ],
                  ),
                ],
                const SizedBox(height: 32),
                AppButton(
                  label: isLogin ? 'Login' : 'Sign Up',
                  isLoading: authState.isLoading,
                  onPressed: isLogin || _agreed ? _handleSubmit : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      children: [
        Expanded(child: _buildToggleItem(AuthMode.login, 'Login')),
        Expanded(child: _buildToggleItem(AuthMode.signup, 'Sign Up')),
      ],
    );
  }

  Widget _buildToggleItem(AuthMode mode, String label) {
    final isSelected = _mode == mode;
    return GestureDetector(
      onTap: () => setState(() => _mode = mode),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.labelMd.copyWith(color: isSelected ? AppColors.accentGreen : AppColors.textSecondary)),
          const SizedBox(height: 8),
          Container(height: 2, color: isSelected ? AppColors.accentGreen : AppColors.surfaceVariant),
        ],
      ),
    );
  }
}
