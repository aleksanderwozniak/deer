library todo_edit_state;

import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';

part 'todo_edit_state.g.dart';

abstract class TodoEditState implements Built<TodoEditState, TodoEditStateBuilder> {
  TodoEntity get todo;
  @nullable
  File get image;
  bool get todoNameHasError;

  TodoEditState._();
  factory TodoEditState({
    TodoEntity todo,
    File image,
    bool todoNameHasError = false,
  }) =>
      _$TodoEditState._(
        todo: todo,
        image: image,
        todoNameHasError: todoNameHasError,
      );
}
