String enumToString(dynamic input) {
  return input.toString().split('.').last;
}

T stringToEnum<T>(String input, List<T> values) {
  return values.firstWhere((e) => input == enumToString(e), orElse: () => null);
}
