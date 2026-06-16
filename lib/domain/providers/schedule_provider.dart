import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleTabProvider = StateProvider<int>((ref) => 0);
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final selectedMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());
