import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class UpdateTodo {
  final TodoEntity todo;

  const UpdateTodo({
    @required this.todo,
  }) : assert(todo != null);
}

class RestoreTodo {
  final TodoEntity todo;

  const RestoreTodo({
    @required this.todo,
  }) : assert(todo != null);
}
