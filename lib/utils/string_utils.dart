String enumToString(dynamic input) {
  return input.toString().split('.').last;
}

String enumToStringSingle(dynamic input) {
  return enumToString(input).split(RegExp('[A-Z]')).first;
}

T stringToEnum<T>(String input, List<T> values) {
  return values.firstWhere((e) => input == enumToString(e), orElse: () => null);
}

bool isBlank(String input) {
  return input.trim().isEmpty;
}

String capitalize(String input) {
  return input[0].toUpperCase() + input.substring(1);
}

String plural({String text, int value}) {
  if (value == 1) {
    return text;
  } else {
    return '$value ${text}s';
  }
}
