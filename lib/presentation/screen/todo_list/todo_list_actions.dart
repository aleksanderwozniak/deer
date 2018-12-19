import 'package:deer/domain/entity/todo_entity.dart';
import 'package:flutter/foundation.dart';

class PerformOnTodo {
  final TodoEntity todo;
  final Operation operation;

  const PerformOnTodo({
    @required this.todo,
    @required this.operation,
  })  : assert(todo != null),
        assert(operation != null);
}

enum Operation { add, archive, favorite }

class ReorderTodo {
  final int oldIndex;
  final int newIndex;

  const ReorderTodo({
    @required this.oldIndex,
    @required this.newIndex,
  })  : assert(oldIndex != null),
        assert(newIndex != null);
}

class FilterBy {
  final String filter;

  const FilterBy({@required this.filter}) : assert(filter != null);
}
