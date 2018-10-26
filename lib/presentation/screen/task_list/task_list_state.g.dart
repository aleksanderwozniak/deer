// GENERATED CODE - DO NOT MODIFY BY HAND

part of task_list_state;

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

class _$TaskListState extends TaskListState {
  @override
  final BuiltList<TaskEntity> tasks;

  factory _$TaskListState([void updates(TaskListStateBuilder b)]) =>
      (new TaskListStateBuilder()..update(updates)).build();

  _$TaskListState._({this.tasks}) : super._() {
    if (tasks == null) {
      throw new BuiltValueNullFieldError('TaskListState', 'tasks');
    }
  }

  @override
  TaskListState rebuild(void updates(TaskListStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskListStateBuilder toBuilder() => new TaskListStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskListState && tasks == other.tasks;
  }

  @override
  int get hashCode {
    return $jf($jc(0, tasks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskListState')..add('tasks', tasks))
        .toString();
  }
}

class TaskListStateBuilder
    implements Builder<TaskListState, TaskListStateBuilder> {
  _$TaskListState _$v;

  ListBuilder<TaskEntity> _tasks;
  ListBuilder<TaskEntity> get tasks =>
      _$this._tasks ??= new ListBuilder<TaskEntity>();
  set tasks(ListBuilder<TaskEntity> tasks) => _$this._tasks = tasks;

  TaskListStateBuilder();

  TaskListStateBuilder get _$this {
    if (_$v != null) {
      _tasks = _$v.tasks?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskListState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TaskListState;
  }

  @override
  void update(void updates(TaskListStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskListState build() {
    _$TaskListState _$result;
    try {
      _$result = _$v ?? new _$TaskListState._(tasks: tasks.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tasks';
        tasks.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskListState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
