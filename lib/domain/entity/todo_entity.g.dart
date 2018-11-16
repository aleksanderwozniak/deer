// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo_entity;

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

class _$TodoEntity extends TodoEntity {
  @override
  final String name;
  @override
  final String description;
  @override
  final BuiltList<BulletEntity> bulletPoints;
  @override
  final BuiltList<String> tags;
  @override
  final TodoStatus status;
  @override
  final DateTime addedDate;
  @override
  final DateTime dueDate;

  factory _$TodoEntity([void updates(TodoEntityBuilder b)]) =>
      (new TodoEntityBuilder()..update(updates)).build();

  _$TodoEntity._(
      {this.name,
      this.description,
      this.bulletPoints,
      this.tags,
      this.status,
      this.addedDate,
      this.dueDate})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'description');
    }
    if (bulletPoints == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'bulletPoints');
    }
    if (tags == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'tags');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'status');
    }
  }

  @override
  TodoEntity rebuild(void updates(TodoEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoEntityBuilder toBuilder() => new TodoEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoEntity &&
        name == other.name &&
        description == other.description &&
        bulletPoints == other.bulletPoints &&
        tags == other.tags &&
        status == other.status &&
        addedDate == other.addedDate &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, name.hashCode), description.hashCode),
                        bulletPoints.hashCode),
                    tags.hashCode),
                status.hashCode),
            addedDate.hashCode),
        dueDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoEntity')
          ..add('name', name)
          ..add('description', description)
          ..add('bulletPoints', bulletPoints)
          ..add('tags', tags)
          ..add('status', status)
          ..add('addedDate', addedDate)
          ..add('dueDate', dueDate))
        .toString();
  }
}

class TodoEntityBuilder implements Builder<TodoEntity, TodoEntityBuilder> {
  _$TodoEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  ListBuilder<BulletEntity> _bulletPoints;
  ListBuilder<BulletEntity> get bulletPoints =>
      _$this._bulletPoints ??= new ListBuilder<BulletEntity>();
  set bulletPoints(ListBuilder<BulletEntity> bulletPoints) =>
      _$this._bulletPoints = bulletPoints;

  ListBuilder<String> _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String> tags) => _$this._tags = tags;

  TodoStatus _status;
  TodoStatus get status => _$this._status;
  set status(TodoStatus status) => _$this._status = status;

  DateTime _addedDate;
  DateTime get addedDate => _$this._addedDate;
  set addedDate(DateTime addedDate) => _$this._addedDate = addedDate;

  DateTime _dueDate;
  DateTime get dueDate => _$this._dueDate;
  set dueDate(DateTime dueDate) => _$this._dueDate = dueDate;

  TodoEntityBuilder();

  TodoEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _description = _$v.description;
      _bulletPoints = _$v.bulletPoints?.toBuilder();
      _tags = _$v.tags?.toBuilder();
      _status = _$v.status;
      _addedDate = _$v.addedDate;
      _dueDate = _$v.dueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoEntity;
  }

  @override
  void update(void updates(TodoEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoEntity build() {
    _$TodoEntity _$result;
    try {
      _$result = _$v ??
          new _$TodoEntity._(
              name: name,
              description: description,
              bulletPoints: bulletPoints.build(),
              tags: tags.build(),
              status: status,
              addedDate: addedDate,
              dueDate: dueDate);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bulletPoints';
        bulletPoints.build();
        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
