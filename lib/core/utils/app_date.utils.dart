import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';

class AppDate {
  AppDate._();
  static final shortDate = DateFormat('MM/dd/yyyy');
  static final longDate = DateFormat('MMMM d, yyyy');
  static final dayOnly = DateFormat('d');
  static final monthOnly = DateFormat('MMMM');
  static final yearOnly = DateFormat('yyyy');
  static final shortYear = DateFormat('yy');
  static final dayMonth = DateFormat('d MMM');
  static final monthDay = DateFormat('MMM d');
  static final time24h = DateFormat('HH:mm');
  static final time12h = DateFormat('h:mm a');
}

extension DateTimeX on DateTime {
  String toSimple() {
    final now = DateTime.now();
    final time = AppDate.time12h.format(this);
    final shortYearStr = now.year == year ? '' : AppDate.shortYear.format(this);

    final date = switch (this) {
      _ when isToday => 'Today',
      _ when wasYesterday => 'Yesterday',
      _ => AppDate.monthDay.format(this),
    };

    final datePart = shortYearStr.isNotEmpty ? "$date  '$shortYearStr" : date;

    return '$datePart, $time';
  }
}
