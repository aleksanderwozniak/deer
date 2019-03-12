import 'package:deer/domain/entity/todo_entity.dart';
import 'package:flutter/foundation.dart';

class UpdateField {
  UpdateField({
    @required this.field,
    @required this.value,
  }) : assert(field != null);

  final Field field;
  final dynamic value;
}

enum Field { selectedDate, calendarFormat, calendarHeaderVisible }

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

class ToggleArchive {}

class ClearArchive {}
