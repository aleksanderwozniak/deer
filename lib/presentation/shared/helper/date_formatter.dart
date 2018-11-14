import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatFull(DateTime date) {
    final formatter = DateFormat('EEEE, d.M.y');

    return formatter.format(date);
  }

  static String safeFormatFull(DateTime date) {
    if (date == null) {
      return 'Not assigned';
    }

    return formatFull(date);
  }

  static String formatDays(DateTime date) {
    final today = DateTime.now();
    final resetToday = DateTime.utc(today.year, today.month, today.day);

    // 'resets' are for ensuring proper difference calculation
    final resetDate = DateTime.utc(date.year, date.month, date.day);
    final difference = resetDate.difference(resetToday);

    return _formatDaysDifference(difference.inDays);
  }

  static String safeFormatDays(DateTime date) {
    if (date == null) {
      return '';
    }

    return formatDays(date);
  }

  static String _formatDaysDifference(int inDays) {
    // TODO: [WIP]
    if (inDays == 0) {
      return 'Today';
    } else if (inDays > 0) {
      if (inDays == 1) {
        return 'Tomorrow';
      } else {
        return '$inDays days';
      }
    } else {
      final daysAbs = inDays.abs();
      if (inDays == -1) {
        return 'Yesterday';
      } else {
        return '$daysAbs days ago';
      }
    }
  }
}
