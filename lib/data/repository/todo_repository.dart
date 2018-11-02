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
  Future<Task> add(TodoEntity todo) async {
    var list = await todos.first;
    list.add(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> remove(TodoEntity todo) async {
    final list = await todos.first;
    list.remove(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }

  // Future<Task> replace(TodoEntity todo) async {
  //   var list = await todos.first;
  //   list.removeWhere((e) => e.addedDate.compareTo(todo.addedDate) == 0);
  //   list.add(todo);

  //   final result = await dao.save(list);
  //   return result ? Task.successful() : Task.failed();
  // }

  Future<Task> replace({
    @required TodoEntity oldTodo,
    @required TodoEntity newTodo,
  }) async {
    var list = await todos.first;
    final index = list.indexOf(oldTodo);
    list.removeAt(index);
    list.insert(index, newTodo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }
}
