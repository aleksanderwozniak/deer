// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo_detail_state;

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

class _$TodoDetailState extends TodoDetailState {
  @override
  final TodoEntity todo;
  @override
  final Task updateTask;

  factory _$TodoDetailState([void updates(TodoDetailStateBuilder b)]) =>
      (new TodoDetailStateBuilder()..update(updates)).build();

  _$TodoDetailState._({this.todo, this.updateTask}) : super._() {
    if (todo == null) {
      throw new BuiltValueNullFieldError('TodoDetailState', 'todo');
    }
    if (updateTask == null) {
      throw new BuiltValueNullFieldError('TodoDetailState', 'updateTask');
    }
  }

  @override
  TodoDetailState rebuild(void updates(TodoDetailStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoDetailStateBuilder toBuilder() =>
      new TodoDetailStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoDetailState &&
        todo == other.todo &&
        updateTask == other.updateTask;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, todo.hashCode), updateTask.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoDetailState')
          ..add('todo', todo)
          ..add('updateTask', updateTask))
        .toString();
  }
}

class TodoDetailStateBuilder
    implements Builder<TodoDetailState, TodoDetailStateBuilder> {
  _$TodoDetailState _$v;

  TodoEntityBuilder _todo;
  TodoEntityBuilder get todo => _$this._todo ??= new TodoEntityBuilder();
  set todo(TodoEntityBuilder todo) => _$this._todo = todo;

  Task _updateTask;
  Task get updateTask => _$this._updateTask;
  set updateTask(Task updateTask) => _$this._updateTask = updateTask;

  TodoDetailStateBuilder();

  TodoDetailStateBuilder get _$this {
    if (_$v != null) {
      _todo = _$v.todo?.toBuilder();
      _updateTask = _$v.updateTask;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoDetailState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoDetailState;
  }

  @override
  void update(void updates(TodoDetailStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoDetailState build() {
    _$TodoDetailState _$result;
    try {
      _$result = _$v ??
          new _$TodoDetailState._(todo: todo.build(), updateTask: updateTask);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'todo';
        todo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoDetailState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
