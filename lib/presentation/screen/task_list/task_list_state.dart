library task_list_state;

import 'package:built_value/built_value.dart';

part 'task_list_state.g.dart';

abstract class TaskListState implements Built<TaskListState, TaskListStateBuilder> {
  String get username;

  TaskListState._();
  factory TaskListState({
    String username = '',
  }) =>
      _$TaskListState._(
        username: username,
      );
}
