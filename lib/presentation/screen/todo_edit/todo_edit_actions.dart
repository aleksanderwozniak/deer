import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class UpdateDate {
  final DateTime date;

  const UpdateDate({this.date});
}

class UpdateField {
  final FieldKey key;
  final dynamic value;

  const UpdateField({
    this.key,
    this.value,
  });
}

enum FieldKey { name, description, bulletPoints, dueDate }

class UpdateTodo {
  final TodoEntity todo;

  const UpdateTodo({this.todo});
}

class Submit {
  final BuildContext context;

  const Submit({this.context});
}
