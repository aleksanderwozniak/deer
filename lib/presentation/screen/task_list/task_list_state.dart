library task_list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/task_entity.dart';

part 'task_list_state.g.dart';

abstract class TaskListState implements Built<TaskListState, TaskListStateBuilder> {
  BuiltList<TaskEntity> get tasks;

  TaskListState._();
  factory TaskListState({
    BuiltList<TaskEntity> tasks,
  }) =>
      _$TaskListState._(
        tasks: tasks ?? BuiltList(),
      );
}
