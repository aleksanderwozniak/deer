library archive_list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

part 'archive_list_state.g.dart';

abstract class ArchiveListState implements Built<ArchiveListState, ArchiveListStateBuilder> {
  BuiltList<TodoEntity> get archivedTodos;
  Task get clearTask;

  ArchiveListState._();
  factory ArchiveListState({
    BuiltList<TodoEntity> archivedTodos,
    Task clearTask = const Task.idle(),
  }) =>
      _$ArchiveListState._(
        archivedTodos: archivedTodos ?? BuiltList(),
        clearTask: clearTask,
      );
}
