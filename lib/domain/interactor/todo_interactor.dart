import 'package:flutter/foundation.dart';
import 'package:tasking/data/repository/todo_repository.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoInteractor {
  final TodoRepository todoRepository;

  TodoInteractor({
    @required this.todoRepository,
  }) : assert(todoRepository != null);

  Stream<List<TodoEntity>> get todos => todoRepository.todos;

  void add(TodoEntity todo) {
    todoRepository.add(todo);
  }

  void remove(TodoEntity todo) {
    todoRepository.remove(todo);
  }
}
