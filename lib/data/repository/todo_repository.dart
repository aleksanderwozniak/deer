import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/todo_dao.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoRepository {
  final TodoDao todoDao;

  TodoRepository({
    @required this.todoDao,
  }) : assert(todoDao != null);

  Stream<List<TodoEntity>> get todos => todoDao.todos;

  void add(TodoEntity todo) {
    todoDao.add(todo);
  }

  void remove(TodoEntity todo) {
    todoDao.remove(todo);
  }
}
