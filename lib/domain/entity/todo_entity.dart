library todo_entity;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/bullet_entity.dart';

part 'todo_entity.g.dart';

abstract class TodoEntity implements Built<TodoEntity, TodoEntityBuilder> {
  String get name;
  String get description;
  BuiltList<BulletEntity> get bulletPoints;
  BuiltList<String> get tags;
  TodoStatus get status;
  bool get isFavorite;
  @nullable
  DateTime get addedDate;
  @nullable
  DateTime get dueDate;
  @nullable
  DateTime get finishedDate;

  TodoEntity._();
  factory TodoEntity({
    String name = '',
    String description = '',
    BuiltList<BulletEntity> bulletPoints,
    BuiltList<String> tags,
    TodoStatus status = TodoStatus.active,
    bool isFavorite = false,
    DateTime addedDate,
    DateTime dueDate,
    DateTime finishedDate,
  }) =>
      _$TodoEntity._(
        name: name,
        description: description,
        bulletPoints: bulletPoints ?? BuiltList(),
        tags: tags ?? BuiltList(),
        status: status,
        isFavorite: isFavorite,
        addedDate: addedDate,
        dueDate: dueDate,
        finishedDate: finishedDate,
      );
}

enum TodoStatus { active, finished }

TodoStatus parse(String input) {
  switch (input) {
    case 'active':
      return TodoStatus.active;
      break;
    case 'finished':
      return TodoStatus.finished;
      break;
    default:
      assert(false);
      return null;
  }
}
