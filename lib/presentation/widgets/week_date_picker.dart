import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';

class WeekDatePicker extends StatefulWidget {
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
  State<WeekDatePicker> createState() => _WeekDatePickerState();
}

class _WeekDatePickerState extends State<WeekDatePicker> {
  late ScrollController _scrollController;
  static const double _itemWidth = 56.0; // 48 width + 8 margin

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedDate());
  }

  @override
  void didUpdateWidget(WeekDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate || oldWidget.selectedMonth != widget.selectedMonth) {
      _scrollToSelectedDate();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedDate() {
    if (!_scrollController.hasClients) return;
    
    final index = widget.selectedDate.day - 1;
    final offset = (index * _itemWidth).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(widget.selectedMonth.year, widget.selectedMonth.month);
    final dates = List.generate(daysInMonth, (index) => DateTime(widget.selectedMonth.year, widget.selectedMonth.month, index + 1));

    return SizedBox(
      height: 72,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final now = DateTime.now();
          final isPast = date.isBefore(DateTime(now.year, now.month, now.day));
          final isSelected = date.day == widget.selectedDate.day && 
                            date.month == widget.selectedDate.month && 
                            date.year == widget.selectedDate.year;

          return GestureDetector(
            onTap: isPast ? null : () => widget.onDateSelected(date),
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
