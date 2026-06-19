import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';

class TimeSlotChip extends StatelessWidget {
  final String startTime;
  final String endTime;
  final bool isSelected;
  final bool available;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.isSelected,
    required this.onTap,
    this.available = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !available;
    final String timeDisplay = endTime.isNotEmpty 
        ? '${formatTimeString(startTime)} - ${formatTimeString(endTime)}'
        : formatTimeString(startTime);

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: endTime.isNotEmpty ? 140 : 100,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDisabled 
              ? AppColors.surfaceVariant.withValues(alpha: 0.5)
              : isSelected 
                  ? AppColors.accentBlue 
                  : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accentBlue : Colors.transparent,
            width: 1,
          ),
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Text(
            timeDisplay,
            style: AppTextStyles.labelMd.copyWith(
              fontSize: endTime.isNotEmpty ? 13 : 14,
              color: isDisabled 
                  ? AppColors.textSecondary.withValues(alpha: 0.5)
                  : isSelected 
                      ? Colors.white 
                      : AppColors.textSecondary,
              decoration: isDisabled ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
