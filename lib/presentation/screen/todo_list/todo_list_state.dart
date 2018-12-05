library todo_list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/domain/interactor/task.dart';

part 'todo_list_state.g.dart';

abstract class TodoListState implements Built<TodoListState, TodoListStateBuilder> {
  BuiltList<TodoEntity> get todos;
  bool get todoNameHasError;
  String get filter;
  Task get diskAccessTask;

  TodoListState._();
  factory TodoListState({
    BuiltList<TodoEntity> todos,
    bool todoNameHasError = false,
    String filter = 'All',
    Task diskAccessTask = const Task.idle(),
  }) =>
      _$TodoListState._(
        todos: todos ?? BuiltList(),
        todoNameHasError: todoNameHasError,
        filter: filter,
        diskAccessTask: diskAccessTask,
      );
}
