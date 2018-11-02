import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class PushTodo {
  final TodoEntity oldTodo;
  final TodoEntity newTodo;

  const PushTodo({
    @required this.oldTodo,
    @required this.newTodo,
  })  : assert(oldTodo != null),
        assert(newTodo != null);
}
