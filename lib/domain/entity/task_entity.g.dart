// GENERATED CODE - DO NOT MODIFY BY HAND

part of task_entity;

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

class _$TaskEntity extends TaskEntity {
  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime addedDate;
  @override
  final DateTime dueDate;

  factory _$TaskEntity([void updates(TaskEntityBuilder b)]) =>
      (new TaskEntityBuilder()..update(updates)).build();

  _$TaskEntity._({this.name, this.description, this.addedDate, this.dueDate})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'description');
    }
    if (addedDate == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'addedDate');
    }
    if (dueDate == null) {
      throw new BuiltValueNullFieldError('TaskEntity', 'dueDate');
    }
  }

  @override
  TaskEntity rebuild(void updates(TaskEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskEntityBuilder toBuilder() => new TaskEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskEntity &&
        name == other.name &&
        description == other.description &&
        addedDate == other.addedDate &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), description.hashCode),
            addedDate.hashCode),
        dueDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskEntity')
          ..add('name', name)
          ..add('description', description)
          ..add('addedDate', addedDate)
          ..add('dueDate', dueDate))
        .toString();
  }
}

class TaskEntityBuilder implements Builder<TaskEntity, TaskEntityBuilder> {
  _$TaskEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  DateTime _addedDate;
  DateTime get addedDate => _$this._addedDate;
  set addedDate(DateTime addedDate) => _$this._addedDate = addedDate;

  DateTime _dueDate;
  DateTime get dueDate => _$this._dueDate;
  set dueDate(DateTime dueDate) => _$this._dueDate = dueDate;

  TaskEntityBuilder();

  TaskEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _description = _$v.description;
      _addedDate = _$v.addedDate;
      _dueDate = _$v.dueDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskEntity;
  }

  @override
  void update(void updates(TaskEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskEntity build() {
    final _$result = _$v ??
        new _$TaskEntity._(
            name: name,
            description: description,
            addedDate: addedDate,
            dueDate: dueDate);
    replace(_$result);
    return _$result;
  }
}
