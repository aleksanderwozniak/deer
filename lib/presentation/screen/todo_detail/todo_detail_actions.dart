import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class PerformOnTodo {
  final TodoEntity todo;
  final Operation operation;

  PerformOnTodo({
    @required this.todo,
    @required this.operation,
  })  : assert(todo != null),
        assert(operation != null);
}

enum Operation { update, restore }
