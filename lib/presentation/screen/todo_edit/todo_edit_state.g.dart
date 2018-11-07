// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo_edit_state;

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

class _$TodoEditState extends TodoEditState {
  @override
  final TodoEntity todo;

  factory _$TodoEditState([void updates(TodoEditStateBuilder b)]) =>
      (new TodoEditStateBuilder()..update(updates)).build();

  _$TodoEditState._({this.todo}) : super._() {
    if (todo == null) {
      throw new BuiltValueNullFieldError('TodoEditState', 'todo');
    }
  }

  @override
  TodoEditState rebuild(void updates(TodoEditStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoEditStateBuilder toBuilder() => new TodoEditStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoEditState && todo == other.todo;
  }

  @override
  int get hashCode {
    return $jf($jc(0, todo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoEditState')..add('todo', todo))
        .toString();
  }
}

class TodoEditStateBuilder
    implements Builder<TodoEditState, TodoEditStateBuilder> {
  _$TodoEditState _$v;

  TodoEntityBuilder _todo;
  TodoEntityBuilder get todo => _$this._todo ??= new TodoEntityBuilder();
  set todo(TodoEntityBuilder todo) => _$this._todo = todo;

  TodoEditStateBuilder();

  TodoEditStateBuilder get _$this {
    if (_$v != null) {
      _todo = _$v.todo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoEditState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoEditState;
  }

  @override
  void update(void updates(TodoEditStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoEditState build() {
    _$TodoEditState _$result;
    try {
      _$result = _$v ?? new _$TodoEditState._(todo: todo.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'todo';
        todo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoEditState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
