library bullet_entity;

import 'package:built_value/built_value.dart';

part 'bullet_entity.g.dart';

abstract class BulletEntity implements Built<BulletEntity, BulletEntityBuilder> {
  String get text;
  bool get checked;

  BulletEntity._();
  factory BulletEntity({
    String text = '',
    bool checked = false,
  }) =>
      _$BulletEntity._(
        text: text,
        checked: checked,
      );
}
