import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/common/app_button.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Payment'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Payment Method', style: AppTextStyles.headingSm),
                  const SizedBox(height: 16),
                   
                   // Card Payment Option
                   _buildPaymentOption(
                     ref: ref,
                     title: 'Card Payment',
                     subtitle: 'Pay securely using your credit/debit card',
                     icon: Icons.credit_card,
                     value: 'card',
                     currentValue: bookingState.paymentMethod,
                   ),
                   
                   const SizedBox(height: 12),
                   
                   // Cash Payment Option
                   _buildPaymentOption(
                     ref: ref,
                     title: 'Hand to Hand Payment',
                     subtitle: 'Pay with cash at the clinic',
                     icon: Icons.payments_outlined,
                     value: 'cash',
                     currentValue: bookingState.paymentMethod,
                   ),

                  const SizedBox(height: 32),
                  Text('Appointment Summary', style: AppTextStyles.headingSm),
                  const SizedBox(height: 16),
                  if (bookingState.selectedServices.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.medical_services, size: 24, color: AppColors.accentBlue),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  bookingState.selectedServices.map((s) => s['name']).join(', '),
                                  style: AppTextStyles.labelMd,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.event_available, size: 20, color: AppColors.textSecondary),
                              const SizedBox(width: 8),
                              Text(
                                '${bookingState.selectedDate?.formattedDate} • ${formatTimeString(bookingState.selectedSlot?.start ?? "")} - ${formatTimeString(bookingState.selectedSlot?.end ?? "")}',
                                style: AppTextStyles.bodySm,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 20, color: AppColors.textSecondary),
                              const SizedBox(width: 8),
                              Text(
                                bookingState.selectedClinic?.name ?? 'Dental Clinic',
                                style: AppTextStyles.bodySm,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Bill', style: AppTextStyles.bodyLg),
                      Text(
                        'PKR ${bookingState.totalBill}',
                        style: AppTextStyles.headingSm.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  if (bookingState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        bookingState.error!,
                        style: const TextStyle(color: AppColors.errorRed),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: AppButton(
              label: bookingState.paymentMethod == 'card' ? 'Pay Now' : 'Confirm Appointment',
              isLoading: bookingState.isLoading,
              onPressed: bookingState.paymentMethod == null
                  ? null
                  : () async {
                      final success = await ref
                          .read(bookingProvider.notifier)
                          .bookAppointment();
                      if (success && context.mounted) {
                        context.go('/book/confirm');
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required String? currentValue,
  }) {
    final isSelected = value == currentValue;
    return GestureDetector(
      onTap: () => ref.read(bookingProvider.notifier).selectPaymentMethod(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.accentGreen : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isSelected ? AppColors.accentGreen : AppColors.accentBlue).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.accentGreen : AppColors.accentBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelMd),
                  Text(subtitle, style: AppTextStyles.bodySm),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.accentGreen),
          ],
        ),
      ),
    );
  }
}
