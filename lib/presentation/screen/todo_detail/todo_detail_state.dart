library todo_detail_state;

import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

part 'todo_detail_state.g.dart';

abstract class TodoDetailState implements Built<TodoDetailState, TodoDetailStateBuilder> {
  TodoEntity get todo;
  Task get updateTask;

  TodoDetailState._();
  factory TodoDetailState({
    TodoEntity todo,
    Task updateTask = const Task.idle(),
  }) =>
      _$TodoDetailState._(
        todo: todo,
        updateTask: updateTask,
      );
}
