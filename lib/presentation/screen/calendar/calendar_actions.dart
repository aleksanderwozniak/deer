import 'package:flutter/foundation.dart';

class UpdateField {
  UpdateField({
    @required this.field,
    @required this.value,
  }) : assert(field != null);

  final Field field;
  final dynamic value;
}

enum Field { selectedDate, scheduledTodos }
