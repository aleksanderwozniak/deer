import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatFullWithTime(DateTime date) {
    final formatter = DateFormat('H:mm - EEEE, dd.MM.y');

    return formatter.format(date);
  }

  static String safeFormatFullWithTime(DateTime date) {
    if (date == null) {
      return 'Not assigned';
    }

    return formatFullWithTime(date);
  }

  static String formatFull(DateTime date) {
    final formatter = DateFormat('EEEE, dd.MM.y');

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
    final days = difference.inDays;

    if (days == 0) {
      return 'Today';
    }

    if (difference.isNegative) {
      // past
      final daysAbs = days.abs();
      if (daysAbs == 1) {
        return 'Yesterday';
      }

      if (daysAbs < 7) {
        return DateFormat("$daysAbs 'days ago'").format(date);
      }

      if (daysAbs < 30) {
        final weeks = (daysAbs / 7).truncate();
        return _pastPlural(text: 'week', value: weeks);
      }

      final months = (daysAbs / 30).truncate();
      return _pastPlural(text: 'month', value: months);
    } else {
      // future
      if (days == 1) {
        return 'Tomorrow';
      }

      if (days < 7) {
        return DateFormat("In $days 'days'").format(date);
      }

      if (days < 30) {
        final weeks = (days / 7).truncate();
        return _futurePlural(text: 'week', value: weeks);
      }

      final months = (days / 30).truncate();
      return _futurePlural(text: 'month', value: months);
    }
  }

  static String safeFormatDays(DateTime date) {
    if (date == null) {
      return '';
    }

    return formatDays(date);
  }

  static String _pastPlural({String text, int value}) {
    if (value == 1) {
      return 'Last $text';
    } else {
      return '$value ${text}s ago';
    }
  }

  static String _futurePlural({String text, int value}) {
    if (value == 1) {
      return 'Next $text';
    } else {
      return 'In $value ${text}s';
    }
  }
}
