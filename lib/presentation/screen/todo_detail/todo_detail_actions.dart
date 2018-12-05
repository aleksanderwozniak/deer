import 'package:deer/domain/entity/todo_entity.dart';
import 'package:flutter/foundation.dart';

class PerformOnTodo {
  final TodoEntity todo;
  final Operation operation;

  PerformOnTodo({
    @required this.todo,
    @required this.operation,
  })  : assert(todo != null),
        assert(operation != null);
}

enum Operation {
  update,
  restore,
  cleanRestore,
  delete,
}
