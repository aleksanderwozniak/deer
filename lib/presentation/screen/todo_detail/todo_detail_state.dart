library todo_detail_state;

import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

part 'todo_detail_state.g.dart';

abstract class TodoDetailState implements Built<TodoDetailState, TodoDetailStateBuilder> {
  TodoEntity get todo;

  TodoDetailState._();
  factory TodoDetailState({
    TodoEntity todo,
  }) =>
      _$TodoDetailState._(
        todo: todo,
      );
}
