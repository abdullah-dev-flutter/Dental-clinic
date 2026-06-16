import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/saved_payment_method_model.dart';

class PaymentMethodTile extends StatelessWidget {
  final SavedPaymentMethodModel method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              _iconForMethod(method.methodType),
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.label, style: AppTextStyles.labelMd),
                  if (method.isDefault)
                    Text('Default', style: AppTextStyles.bodySm),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.accentGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForMethod(String methodType) {
    switch (methodType) {
      case 'card':
        return Icons.credit_card;
      case 'cash':
        return Icons.payments;
      case 'insurance':
        return Icons.health_and_safety;
      case 'online':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }
}
