import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class PushTodo {
  final TodoEntity todo;

  const PushTodo({
    @required this.todo,
  }) : assert(todo != null);
}
