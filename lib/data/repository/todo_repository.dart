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
  Stream<List<TodoEntity>> get unassigned => dao.unassigned;
  Stream<List<TodoEntity>> get finished => dao.finished;

  // Future<Task> add(TodoEntity todo) async {
  //   var list = await all.first ?? List<TodoEntity>();
  //   list.add(todo);

  //   final result = await dao.save(list);
  //   return result ? Task.successful() : Task.failed();
  // }

  // Future<Task> remove(TodoEntity todo) async {
  //   final list = await all.first;
  //   list.remove(todo);

  //   final result = await dao.save(list);
  //   return result ? Task.successful() : Task.failed();
  // }

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

  // Future<Task> replace({
  //   @required TodoEntity oldTodo,
  //   @required TodoEntity newTodo,
  // }) async {
  //   var list = await all.first;
  //   final index = list.indexOf(oldTodo);
  //   list.removeAt(index);
  //   list.insert(index, newTodo);

  //   final result = await dao.save(list);
  //   return result ? Task.successful() : Task.failed();
  // }
}
