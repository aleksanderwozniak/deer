import 'package:built_collection/built_collection.dart';
import 'package:tasking/data/json/bullet_json.dart';
import 'package:tasking/data/json/todo_json.dart';
import 'package:tasking/domain/entity/bullet_entity.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoMapper {
  TodoMapper._();

  static TodoJson toJson(TodoEntity todo) {
    return TodoJson(
      name: todo.name,
      description: todo.description,
      bulletPoints: todo.bulletPoints.map(bulletToJson).toList(),
      status: todo.status,
      addedDate: todo.addedDate,
      dueDate: todo.dueDate,
    );
  }

  static TodoEntity fromJson(TodoJson json) {
    return TodoEntity(
      name: json.name,
      description: json.description,
      bulletPoints: BuiltList(json.bulletPoints.map(bulletFromJson)),
      status: json.status,
      addedDate: json.addedDate,
      dueDate: json.dueDate,
    );
  }

  static BulletJson bulletToJson(BulletEntity entity) {
    return BulletJson(
      text: entity.text,
      checked: entity.checked,
    );
  }

  static BulletEntity bulletFromJson(BulletJson json) {
    return BulletEntity(
      text: json.text,
      checked: json.checked,
    );
  }
}
