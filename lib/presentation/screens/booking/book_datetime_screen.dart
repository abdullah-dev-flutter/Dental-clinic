import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/booking_provider.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/month_picker_row.dart';
import '../../widgets/week_date_picker.dart';
import '../../widgets/time_slot_chip.dart';
import '../../../core/utils/date_formatter.dart';

class BookDateTimeScreen extends ConsumerStatefulWidget {
  const BookDateTimeScreen({super.key});

  @override
  ConsumerState<BookDateTimeScreen> createState() => _BookDateTimeScreenState();
}

class _BookDateTimeScreenState extends ConsumerState<BookDateTimeScreen> {
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingState = ref.read(bookingProvider);
      if (bookingState.selectedDate == null) {
        final now = DateTime.now();
        ref.read(bookingProvider.notifier).selectDate(DateTime(now.year, now.month, now.day));
      }
    });
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);
    final selectedDate = bookingState.selectedDate ?? DateTime.now();
    final slotsAsync = ref.watch(availableSlotsProvider(selectedDate));

    // Auto-select first available slot when slots load and none selected
    ref.listen(availableSlotsProvider(selectedDate), (prev, next) {
      if (next.hasValue &&
          next.value!.isNotEmpty &&
          bookingState.selectedSlot == null) {
        final firstAvailable =
            next.value!.where((s) => s.available).firstOrNull;
        if (firstAvailable != null) {
          ref.read(bookingProvider.notifier).selectSlot(firstAvailable);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Select Schedule'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSectionHeader('Select Date'),
                  const SizedBox(height: 12),
                  MonthPickerRow(
                    selectedMonth: selectedDate,
                    onMonthSelected: (date) {
                      final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
                      final safeDay = selectedDate.day.clamp(1, daysInMonth);
                      ref.read(bookingProvider.notifier).selectDate(DateTime(date.year, date.month, safeDay));
                    },
                  ),
                  const SizedBox(height: 16),
                  WeekDatePicker(
                    selectedMonth: selectedDate,
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      ref.read(bookingProvider.notifier).selectDate(date);
                    },
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Available Time'),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: slotsAsync.when(
                      data: (slots) {
                        if (slots.isEmpty) {
                          return _buildEmptySlots();
                        }

                        final morning = slots.where((s) => int.parse(s.start.split(':')[0]) < 12).toList();
                        final afternoon = slots.where((s) {
                          final h = int.parse(s.start.split(':')[0]);
                          return h >= 12 && h < 17;
                        }).toList();
                        final evening = slots.where((s) => int.parse(s.start.split(':')[0]) >= 17).toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (morning.isNotEmpty) ...[
                              _buildTimeCategory('Morning', Icons.wb_sunny_outlined),
                              const SizedBox(height: 12),
                              _buildSlotGrid(morning, bookingState),
                              const SizedBox(height: 24),
                            ],
                            if (afternoon.isNotEmpty) ...[
                              _buildTimeCategory('Afternoon', Icons.wb_cloudy_outlined),
                              const SizedBox(height: 12),
                              _buildSlotGrid(afternoon, bookingState),
                              const SizedBox(height: 24),
                            ],
                            if (evening.isNotEmpty) ...[
                              _buildTimeCategory('Evening', Icons.dark_mode_outlined),
                              const SizedBox(height: 12),
                              _buildSlotGrid(evening, bookingState),
                              const SizedBox(height: 24),
                            ],
                          ],
                        );
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(color: AppColors.accentGreen),
                        ),
                      ),
                      error: (e, _) => Center(
                        child: Text(
                          'Failed to load slots. Please try again.',
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.errorRed),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionHeader('Notes'),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _noteCtrl,
                      maxLines: 3,
                      onChanged: (v) => ref.read(bookingProvider.notifier).setNote(v),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Any special requests?',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(bookingState),
        ],
      ),
    );
  }

  Widget _buildTimeCategory(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(title, style: AppTextStyles.labelSm.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildSlotGrid(List<dynamic> slots, BookingState bookingState) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: slots.map((slot) {
        return TimeSlotChip(
          startTime: slot.start,
          endTime: slot.end,
          available: slot.available,
          isSelected: bookingState.selectedSlot?.start == slot.start,
          onTap: () => ref.read(bookingProvider.notifier).selectSlot(slot),
        );
      }).toList(),
    );
  }
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(title, style: AppTextStyles.headingSm),
    );
  }

  Widget _buildEmptySlots() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.event_busy, size: 48, color: Colors.grey.shade700),
          const SizedBox(height: 12),
          Text(
            'No slots available for this day.',
            style: AppTextStyles.bodyMd.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BookingState state) {
    final bool canContinue = state.selectedSlot != null && state.selectedDate != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (canContinue)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  const Icon(Icons.event_available, color: AppColors.accentGreen, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '${state.selectedDate!.formattedDate} • ${formatTimeString(state.selectedSlot!.start)} - ${formatTimeString(state.selectedSlot!.end)}',
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.accentGreen),
                  ),
                ],
              ),
            ),
          AppButton(
            label: 'Continue to Payment',
            onPressed: canContinue ? () => context.push('/payment') : null,
          ),
        ],
      ),
    );
  }
}

