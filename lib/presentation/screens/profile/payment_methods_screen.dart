import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/payment_method_tile.dart';

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethodsAsync = ref.watch(savedPaymentMethodsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Payment Methods'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: paymentMethodsAsync.when(
        data: (methods) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: methods.length,
          itemBuilder: (context, index) {
            return PaymentMethodTile(
              method: methods[index],
              isSelected: methods[index].isDefault,
              onTap: () {},
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) =>
            const Center(child: Text('Error loading payment methods')),
      ),
    );
  }
}
