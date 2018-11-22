import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/todo_dao.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

class TodoRepository {
  final TodoDao dao;

  TodoRepository({
    @required this.dao,
  }) : assert(dao != null);

  Stream<List<TodoEntity>> get all => dao.all;
  Stream<List<TodoEntity>> get active => dao.active;
  Stream<List<TodoEntity>> get finished => dao.finished;
  Stream<List<TodoEntity>> filtered(String filter) => dao.filtered(filter);

  Future<Task> add(TodoEntity todo) async {
    final result = await dao.add(todo);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> remove(TodoEntity todo) async {
    final result = await dao.remove(todo);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> update(TodoEntity todo) async {
    final result = await dao.update(todo);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> clearArchive() async {
    final result = await dao.clearFinished();
    return result ? Task.successful() : Task.failed();
  }
}
