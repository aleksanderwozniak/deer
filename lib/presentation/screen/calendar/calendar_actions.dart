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

enum Field { selectedDate, calendarFormat }

class AddTodo {
  final TodoEntity todo;

  const AddTodo(this.todo) : assert(todo != null);
}
