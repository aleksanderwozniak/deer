import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/todo_dao.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

class TodoRepository {
  final TodoDao dao;

  TodoRepository({
    @required this.dao,
  }) : assert(dao != null);

  Stream<List<TodoEntity>> get todos => dao.todos;

  // Unused; for SwipeToRefresh
  // Future<Task> load() async {
  //   await dao.loadFromDisk();
  //   return Task.successful();
  // }

  Future<Task> remove(TodoEntity todo) async {
    final list = await todos.first;
    list.remove(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> add(TodoEntity todo) async {
    var list = await todos.first;
    list.add(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }
}
