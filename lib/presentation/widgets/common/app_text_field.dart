import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final bool obscure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final int? maxLength;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.obscure = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.enabled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? AppColors.accentGreen : Colors.transparent,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscure,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        style: AppTextStyles.bodyLg.copyWith(
          color: widget.enabled ? AppColors.textPrimary : AppColors.textSecondary,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppTextStyles.bodyLg.copyWith(color: AppColors.textHint),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          suffixIcon: widget.suffixIcon,
          counterText: '',
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }
}
