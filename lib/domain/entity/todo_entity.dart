library todo_entity;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'todo_entity.g.dart';

abstract class TodoEntity implements Built<TodoEntity, TodoEntityBuilder> {
  String get name;
  String get description;
  BuiltList<String> get bulletPoints;
  TodoStatus get status;
  @nullable
  DateTime get addedDate;
  @nullable
  DateTime get dueDate;

  TodoEntity._();
  factory TodoEntity({
    String name = '',
    String description = '',
    BuiltList<String> bulletPoints,
    TodoStatus status = TodoStatus.unassigned,
    DateTime addedDate,
    DateTime dueDate,
  }) =>
      _$TodoEntity._(
        name: name,
        description: description,
        bulletPoints: bulletPoints ?? BuiltList(),
        status: status,
        addedDate: addedDate,
        dueDate: dueDate,
      );
}

enum TodoStatus { unassigned, finished }

TodoStatus parse(String input) {
  switch (input) {
    case 'unassigned':
      return TodoStatus.unassigned;
      break;
    case 'finished':
      return TodoStatus.finished;
      break;
    default:
      assert(false);
      return null;
  }
}
