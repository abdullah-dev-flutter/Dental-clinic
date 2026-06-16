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

class BookDateTimeScreen extends ConsumerStatefulWidget {
  const BookDateTimeScreen({super.key});

  @override
  ConsumerState<BookDateTimeScreen> createState() => _BookDateTimeScreenState();
}

class _BookDateTimeScreenState extends ConsumerState<BookDateTimeScreen> {
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);
    // Use a default date if none selected to ensure UI is always shown
    final selectedDate = bookingState.selectedDate ?? DateTime.now();
    final slotsAsync = ref.watch(availableSlotsProvider(selectedDate));

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
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: slots.map((slot) {
                            return TimeSlotChip(
                              time: slot.start,
                              isSelected: bookingState.selectedSlot?.start == slot.start,
                              onTap: () => ref.read(bookingProvider.notifier).selectSlot(slot),
                            );
                          }).toList(),
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
                  const SizedBox(height: 32),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10)],
      ),
      child: AppButton(
        label: 'Continue to Payment',
        onPressed: canContinue ? () => context.push('/payment') : null,
      ),
    );
  }
}

