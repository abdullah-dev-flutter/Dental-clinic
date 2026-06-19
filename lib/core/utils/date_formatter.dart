import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formattedDate => DateFormat('MMM d, yyyy').format(this);
  String get formattedTime => DateFormat('h:mm a').format(this);
  String get dayLabel => DateFormat('EE').format(this).substring(0, 2);
  String get monthName => DateFormat('MMM').format(this);
  String get monthYear => year == DateTime.now().year 
      ? DateFormat('MMM').format(this) 
      : DateFormat('MMM yyyy').format(this);
}

String formatTimeString(String timeStr) {
  try {
    // Handle HH:mm:ss or HH:mm
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final dt = DateTime(0, 1, 1, hour, minute);
    return DateFormat('h:mm a').format(dt);
  } catch (e) {
    return timeStr;
  }
}
