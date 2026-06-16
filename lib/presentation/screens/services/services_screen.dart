import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/providers/home_providers.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/service_item_card.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesState = ref.watch(dentalServicesProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Services'),
      ),
      body: servicesState.when(
        data: (services) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
                CurvedAnimation(
                  parent: _animController,
                  curve: Interval((index * 0.1).clamp(0.0, 1.0), 1.0, curve: Curves.easeOut),
                ),
              );
              final fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animController,
                  curve: Interval((index * 0.1).clamp(0.0, 1.0), 1.0, curve: Curves.easeIn),
                ),
              );
              return SlideTransition(
                position: animation,
                child: FadeTransition(
                  opacity: fadeAnim,
                  child: ServiceItemCard(
                    service: services[index],
                    onTap: () {
                      ref.read(bookingProvider.notifier).reset();
                      ref.read(bookingProvider.notifier).selectService(services[index]);
                      context.push('/book/service');
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Error loading services')),
      ),
    );
  }
}
