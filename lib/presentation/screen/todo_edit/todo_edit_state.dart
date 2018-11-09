library todo_edit_state;

import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

part 'todo_edit_state.g.dart';

abstract class TodoEditState implements Built<TodoEditState, TodoEditStateBuilder> {
  TodoEntity get todo;
  bool get todoNameHasError;

  TodoEditState._();
  factory TodoEditState({
    TodoEntity todo,
    bool todoNameHasError = false,
  }) =>
      _$TodoEditState._(
        todo: todo,
        todoNameHasError: todoNameHasError,
      );
}
