import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';

class MonthPickerRow extends StatelessWidget {
  final DateTime selectedMonth;
  final ValueChanged<DateTime> onMonthSelected;

  const MonthPickerRow({super.key, required this.selectedMonth, required this.onMonthSelected});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = List.generate(6, (index) => DateTime(now.year, now.month + index));

    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final month = months[index];
          final isSelected = month.month == selectedMonth.month && month.year == selectedMonth.year;

          return GestureDetector(
            onTap: () => onMonthSelected(month),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                month.monthYear,
                style: AppTextStyles.labelMd.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
