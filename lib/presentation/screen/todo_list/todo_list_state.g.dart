// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo_list_state;

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

class _$TodoListState extends TodoListState {
  @override
  final BuiltList<TodoEntity> todos;
  @override
  final Task diskAccessTask;

  factory _$TodoListState([void updates(TodoListStateBuilder b)]) =>
      (new TodoListStateBuilder()..update(updates)).build();

  _$TodoListState._({this.todos, this.diskAccessTask}) : super._() {
    if (todos == null) {
      throw new BuiltValueNullFieldError('TodoListState', 'todos');
    }
    if (diskAccessTask == null) {
      throw new BuiltValueNullFieldError('TodoListState', 'diskAccessTask');
    }
  }

  @override
  TodoListState rebuild(void updates(TodoListStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoListStateBuilder toBuilder() => new TodoListStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoListState &&
        todos == other.todos &&
        diskAccessTask == other.diskAccessTask;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, todos.hashCode), diskAccessTask.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoListState')
          ..add('todos', todos)
          ..add('diskAccessTask', diskAccessTask))
        .toString();
  }
}

class TodoListStateBuilder
    implements Builder<TodoListState, TodoListStateBuilder> {
  _$TodoListState _$v;

  ListBuilder<TodoEntity> _todos;
  ListBuilder<TodoEntity> get todos =>
      _$this._todos ??= new ListBuilder<TodoEntity>();
  set todos(ListBuilder<TodoEntity> todos) => _$this._todos = todos;

  Task _diskAccessTask;
  Task get diskAccessTask => _$this._diskAccessTask;
  set diskAccessTask(Task diskAccessTask) =>
      _$this._diskAccessTask = diskAccessTask;

  TodoListStateBuilder();

  TodoListStateBuilder get _$this {
    if (_$v != null) {
      _todos = _$v.todos?.toBuilder();
      _diskAccessTask = _$v.diskAccessTask;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoListState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoListState;
  }

  @override
  void update(void updates(TodoListStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoListState build() {
    _$TodoListState _$result;
    try {
      _$result = _$v ??
          new _$TodoListState._(
              todos: todos.build(), diskAccessTask: diskAccessTask);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'todos';
        todos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoListState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
