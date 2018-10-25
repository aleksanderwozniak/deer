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
  final String username;

  factory _$TaskListState([void updates(TaskListStateBuilder b)]) =>
      (new TaskListStateBuilder()..update(updates)).build();

  _$TaskListState._({this.username}) : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError('TaskListState', 'username');
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
    return other is TaskListState && username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(0, username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskListState')
          ..add('username', username))
        .toString();
  }
}

class TaskListStateBuilder
    implements Builder<TaskListState, TaskListStateBuilder> {
  _$TaskListState _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  TaskListStateBuilder();

  TaskListStateBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
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
    final _$result = _$v ?? new _$TaskListState._(username: username);
    replace(_$result);
    return _$result;
  }
}
