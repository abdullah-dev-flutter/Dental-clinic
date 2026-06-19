import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/payment_method_tile.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final paymentMethodsAsync = ref.watch(savedPaymentMethodsProvider);

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
                  Text('Payment Method', style: AppTextStyles.headingSm),
                  const SizedBox(height: 16),
                  paymentMethodsAsync.when(
                    data: (methods) {
                      if (methods.isEmpty) {
                        return const Center(
                          child: Text('No saved payment methods found.'),
                        );
                      }
                      return Column(
                        children: methods.map((m) {
                          return PaymentMethodTile(
                            method: m,
                            isSelected:
                                bookingState.selectedPaymentMethod?.id == m.id,
                            onTap: () => ref
                                .read(bookingProvider.notifier)
                                .selectPaymentMethod(m),
                          );
                        }).toList(),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 32),
                  Text('Appointment Summary', style: AppTextStyles.headingSm),
                  const SizedBox(height: 16),
                  if (bookingState.selectedService != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.medical_services, size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookingState.selectedService!.name,
                                  style: AppTextStyles.labelMd,
                                ),
                                if (bookingState.selectedDoctor != null)
                                  Text(
                                    bookingState.selectedDoctor!.fullName,
                                    style: AppTextStyles.bodySm,
                                  ),
                                const SizedBox(height: 8),

                                Text(
                                  '${bookingState.selectedDate?.formattedDate} • ${formatTimeString(bookingState.selectedSlot?.start ?? "")} - ${formatTimeString(bookingState.selectedSlot?.end ?? "")}',
                                  style: AppTextStyles.bodySm,
                                ),
                                Text(
                                  bookingState.selectedClinic?.name ??
                                      'Greenwich Village',
                                  style: AppTextStyles.bodySm,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total: ', style: AppTextStyles.bodyLg),
                      Text(
                        'USD ${bookingState.selectedService?.price.toInt()}',
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
              label: 'Pay Now',
              isLoading: bookingState.isLoading,
              onPressed: bookingState.selectedPaymentMethod == null
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
}
