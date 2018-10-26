library todo_entity;

import 'package:built_value/built_value.dart';

part 'todo_entity.g.dart';

abstract class TodoEntity implements Built<TodoEntity, TodoEntityBuilder> {
  String get name;
  String get description;
  @nullable
  DateTime get addedDate;
  @nullable
  DateTime get dueDate;

  TodoEntity._();
  factory TodoEntity({
    String name = '',
    String description = '',
    DateTime addedDate,
    DateTime dueDate,
  }) =>
      _$TodoEntity._(
        name: name,
        description: description,
        addedDate: addedDate,
        dueDate: dueDate,
      );
}
