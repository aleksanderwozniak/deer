import 'package:flutter/foundation.dart';

class UpdateField {
  UpdateField({
    @required this.field,
    @required this.value,
  }) : assert(field != null);

  final Field field;
  final dynamic value;
}

enum Field { username }

class UpdateBullets {
  final String text;
  final int index; // MARK: THIS COULD BE GOOD

  UpdateBullets({
    @required this.text,
    @required this.index,
  });
}
