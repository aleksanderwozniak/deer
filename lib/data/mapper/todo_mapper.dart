import 'package:built_collection/built_collection.dart';
import 'package:tasking/data/json/todo_json.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoMapper {
  TodoMapper._();

  static TodoJson toJson(TodoEntity todo) {
    return TodoJson(
      name: todo.name,
      description: todo.description,
      bulletPoints: todo.bulletPoints.toList(),
      status: todo.status,
      addedDate: todo.addedDate,
      dueDate: todo.dueDate,
    );
  }

  static TodoEntity fromJson(TodoJson json) {
    return TodoEntity(
      name: json.name,
      description: json.description,
      bulletPoints: BuiltList(json.bulletPoints),
      status: json.status,
      addedDate: json.addedDate,
      dueDate: json.dueDate,
    );
  }
}
