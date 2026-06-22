import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../domain/verification_providers.dart';
import '../domain/doctor_verification_model.dart';
import 'package:intl/intl.dart';

class RejectedDoctorsScreen extends ConsumerWidget {
  const RejectedDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rejectedAsync = ref.watch(rejectedDoctorsProvider);

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rejected Applications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => ref.invalidate(rejectedDoctorsProvider),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: rejectedAsync.when(
                data: (doctors) {
                  if (doctors.isEmpty) {
                    return const Center(child: Text('No rejected applications.', style: TextStyle(color: Colors.grey, fontSize: 16)));
                  }
                  return _buildTable(context, ref, doctors);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error loading data: $e')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context, WidgetRef ref, List<DoctorVerificationModel> doctors) {
    return ListView.separated(
      itemCount: doctors.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final doc = doctors[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          leading: CircleAvatar(
            backgroundColor: AppColors.errorRed.withOpacity(0.1),
            child: const Icon(Icons.close, color: AppColors.errorRed),
          ),
          title: Text(doc.fullName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('Reason: ${doc.rejectionReason ?? "None provided"}', style: TextStyle(color: AppColors.errorRed.withOpacity(0.8))),
              Text('Applied: ${DateFormat('MMM dd, yyyy').format(doc.createdAt)}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.accentBlue,
              side: const BorderSide(color: AppColors.accentBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              ref.read(selectedDoctorProvider.notifier).state = doc;
              context.go('/admin/doctor/detail');
            },
            child: const Text('Review Again'),
          ),
        );
      },
    );
  }
}
