import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/upcoming_appointment_model.dart';
import '../../../domain/providers/appointment_provider.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../../../domain/providers/home_providers.dart'; // Added for upcomingAppointmentsProvider invalidation
import '../../widgets/month_picker_row.dart';
import '../../widgets/week_date_picker.dart';
import '../../widgets/upcoming_appointment_card.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(scheduleTabProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final appointmentState = ref.watch(appointmentProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.notifications_none), 
          onPressed: () => context.push('/notifications'),
        ),
        title: const Text('Schedule'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(color: AppColors.accentGreen, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.add, color: AppColors.background), 
              onPressed: () => context.push('/book/service'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTab('Upcoming', 0, tabIndex, ref),
              _buildTab('Completed', 1, tabIndex, ref),
              _buildTab('Cancelled', 2, tabIndex, ref),
            ],
          ),
          const SizedBox(height: 16),
          if (tabIndex == 0) ...[
            MonthPickerRow(
              selectedMonth: selectedMonth,
              onMonthSelected: (d) => ref.read(selectedMonthProvider.notifier).state = d,
            ),
            const SizedBox(height: 16),
            WeekDatePicker(
              selectedMonth: selectedMonth,
              selectedDate: selectedDate,
              onDateSelected: (d) => ref.read(selectedDateProvider.notifier).state = d,
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: _buildList(context, tabIndex, appointmentState, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, int currentIndex, WidgetRef ref) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => ref.read(scheduleTabProvider.notifier).state = index,
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.labelMd.copyWith(
              color: isActive ? AppColors.accentGreen : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? 40 : 0,
            color: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref, String appointmentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              ref.read(appointmentProvider.notifier).cancelAppointment(appointmentId);
              ref.invalidate(upcomingAppointmentsProvider); // Update home screen too
              Navigator.pop(context);
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, int tabIndex, AppointmentState state, WidgetRef ref) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator());

    final selectedDate = ref.watch(selectedDateProvider);
    List<UpcomingAppointmentModel> appointments = [];
    
    if (tabIndex == 0) {
      appointments = state.upcoming.where((appt) {
        return appt.appointmentDate.year == selectedDate.year &&
               appt.appointmentDate.month == selectedDate.month &&
               appt.appointmentDate.day == selectedDate.day;
      }).toList();
    } else if (tabIndex == 1) {
      appointments = state.completed;
    } else if (tabIndex == 2) {
      appointments = state.cancelled;
    }

    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy, size: 80, color: AppColors.surfaceVariant),
            const SizedBox(height: 16),
            Text('No appointments yet', style: AppTextStyles.bodyMd),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(appointmentProvider.notifier).loadAppointments(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return UpcomingAppointmentCard(
            appointment: appointment,
            showBadge: tabIndex == 0,
            isExpandable: true,
            onCancel: tabIndex == 0 ? () => _showCancelDialog(context, ref, appointment.id) : null,
          );
        },
      ),
    );
  }
}
