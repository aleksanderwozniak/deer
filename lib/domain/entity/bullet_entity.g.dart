// GENERATED CODE - DO NOT MODIFY BY HAND

part of bullet_entity;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

class _$BulletEntity extends BulletEntity {
  @override
  final String text;
  @override
  final bool checked;

  factory _$BulletEntity([void updates(BulletEntityBuilder b)]) =>
      (new BulletEntityBuilder()..update(updates)).build();

  _$BulletEntity._({this.text, this.checked}) : super._() {
    if (text == null) {
      throw new BuiltValueNullFieldError('BulletEntity', 'text');
    }
    if (checked == null) {
      throw new BuiltValueNullFieldError('BulletEntity', 'checked');
    }
  }

  @override
  BulletEntity rebuild(void updates(BulletEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BulletEntityBuilder toBuilder() => new BulletEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BulletEntity &&
        text == other.text &&
        checked == other.checked;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, text.hashCode), checked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BulletEntity')
          ..add('text', text)
          ..add('checked', checked))
        .toString();
  }
}

class BulletEntityBuilder
    implements Builder<BulletEntity, BulletEntityBuilder> {
  _$BulletEntity _$v;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  bool _checked;
  bool get checked => _$this._checked;
  set checked(bool checked) => _$this._checked = checked;

  BulletEntityBuilder();

  BulletEntityBuilder get _$this {
    if (_$v != null) {
      _text = _$v.text;
      _checked = _$v.checked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BulletEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BulletEntity;
  }

  @override
  void update(void updates(BulletEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BulletEntity build() {
    final _$result = _$v ?? new _$BulletEntity._(text: text, checked: checked);
    replace(_$result);
    return _$result;
  }
}
