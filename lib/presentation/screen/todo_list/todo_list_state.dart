library todo_list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

part 'todo_list_state.g.dart';

abstract class TodoListState implements Built<TodoListState, TodoListStateBuilder> {
  BuiltList<TodoEntity> get todos;
  bool get todoNameHasError;
  Task get diskAccessTask;

  TodoListState._();
  factory TodoListState({
    BuiltList<TodoEntity> todos,
    bool todoNameHasError = false,
    Task diskAccessTask = const Task.idle(),
  }) =>
      _$TodoListState._(
        todos: todos ?? BuiltList(),
        todoNameHasError: todoNameHasError,
        diskAccessTask: diskAccessTask,
      );
}
