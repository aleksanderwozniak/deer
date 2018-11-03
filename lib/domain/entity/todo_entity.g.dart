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
  final TodoStatus status;
  @override
  final DateTime addedDate;
  @override
  final DateTime dueDate;

  factory _$TodoEntity([void updates(TodoEntityBuilder b)]) =>
      (new TodoEntityBuilder()..update(updates)).build();

  _$TodoEntity._(
      {this.name, this.description, this.status, this.addedDate, this.dueDate})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('TodoEntity', 'description');
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
        status == other.status &&
        addedDate == other.addedDate &&
        dueDate == other.dueDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, name.hashCode), description.hashCode),
                status.hashCode),
            addedDate.hashCode),
        dueDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoEntity')
          ..add('name', name)
          ..add('description', description)
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
    final _$result = _$v ??
        new _$TodoEntity._(
            name: name,
            description: description,
            status: status,
            addedDate: addedDate,
            dueDate: dueDate);
    replace(_$result);
    return _$result;
  }
}
