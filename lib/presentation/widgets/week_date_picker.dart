import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';

class WeekDatePicker extends StatelessWidget {
  final DateTime selectedMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const WeekDatePicker({
    super.key,
    required this.selectedMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(selectedMonth.year, selectedMonth.month);
    final dates = List.generate(daysInMonth, (index) => DateTime(selectedMonth.year, selectedMonth.month, index + 1));

    return SizedBox(
      height: 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final now = DateTime.now();
          final isPast = date.isBefore(DateTime(now.year, now.month, now.day));
          final isSelected = date.day == selectedDate.day && date.month == selectedDate.month && date.year == selectedDate.year;

          return GestureDetector(
            onTap: isPast ? null : () => onDateSelected(date),
            child: Container(
              width: 48,
              margin: const EdgeInsets.only(right: 8),
              child: Opacity(
                opacity: isPast ? 0.3 : 1.0,
                child: Column(
                  children: [
                    Text(date.dayLabel, style: AppTextStyles.labelSm),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.accentBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: AppTextStyles.labelMd.copyWith(
                          fontSize: 16,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
