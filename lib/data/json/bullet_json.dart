import 'package:flutter/foundation.dart';

class BulletJson {
  final String text;
  final bool checked;

  const BulletJson({
    @required this.text,
    @required this.checked,
  })  : assert(text != null),
        assert(checked != null);

  static BulletJson parse(Map<String, dynamic> json) {
    return BulletJson(
      text: json['text'] ?? '',
      checked: json['checked'] ?? false,
    );
  }

  Map encode() {
    return {
      'text': text,
      'checked': checked,
    };
  }
}
