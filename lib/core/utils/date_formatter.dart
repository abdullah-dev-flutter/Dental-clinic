import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formattedDate => DateFormat('MMM d, yyyy').format(this);
  String get formattedTime => DateFormat('h:mm a').format(this);
  String get dayLabel => DateFormat('EE').format(this).substring(0, 2);
  String get monthName => DateFormat('MMM').format(this);
}
