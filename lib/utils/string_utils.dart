String enumToString(dynamic input) {
  return input.toString().split('.').last;
}

T stringToEnum<T>(String input, List<T> values) {
  return values.firstWhere((e) => input == enumToString(e), orElse: () => null);
}

bool isBlank(String input) {
  return input.trim().isEmpty;
}

String plural({String text, int value}) {
  if (value == 1) {
    return text;
  } else {
    return '$value ${text}s';
  }
}
