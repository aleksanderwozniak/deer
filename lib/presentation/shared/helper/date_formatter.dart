class DateFormatter {
  DateFormatter._();

  static String formatSimple(DateTime date) {
    if (date == null) {
      return '';
    }

    final buffer = new StringBuffer();

    buffer.write(date.weekday);
    buffer.write(', ');
    buffer.write(date.day);
    buffer.write('.');
    buffer.write(date.month);
    buffer.write('.');
    buffer.write(date.year);

    return buffer.toString();
  }
}
