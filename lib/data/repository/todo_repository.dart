import 'package:deer/data/dao/todo_dao.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/domain/interactor/task.dart';
import 'package:flutter/foundation.dart';

class TodoRepository {
  final TodoDao dao;

  TodoRepository({
    @required this.dao,
  }) : assert(dao != null);

  Stream<List<TodoEntity>> get all => dao.all;
  Stream<List<TodoEntity>> get active => dao.active;
  Stream<List<TodoEntity>> get finished => dao.finished;
  Stream<String> get filter => dao.filter;

  void setFilter(String value) {
    dao.setFilter(value);
  }

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

  Future<Task> reorder(int oldIndex, int newIndex) async {
    final result = await dao.reorder(oldIndex, newIndex);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> clearArchive() async {
    final result = await dao.clearFinished();
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> clearNotifications() async {
    final result = await dao.clearNotifications();
    return result ? Task.successful() : Task.failed();
  }
}
