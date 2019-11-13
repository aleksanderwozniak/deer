bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

DateTime normalizedDate(DateTime value) {
  return DateTime.utc(value.year, value.month, value.day, 12);
}
