import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:deer/data/repository/todo_repository.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/domain/interactor/task.dart';

class TodoInteractor {
  final TodoRepository todoRepository;

  TodoInteractor({
    @required this.todoRepository,
  }) : assert(todoRepository != null);

  Stream<List<TodoEntity>> get all => todoRepository.all;
  Stream<List<TodoEntity>> get active => todoRepository.active;
  Stream<List<TodoEntity>> get finished => todoRepository.finished;
  Stream<String> get filter => todoRepository.filter;

  void setFilter(String value) {
    todoRepository.setFilter(value);
  }

  Stream<Task> add(TodoEntity todo) {
    return Observable.fromFuture(todoRepository.add(todo)).startWith(Task.running());
  }

  Stream<Task> remove(TodoEntity todo) {
    return Observable.fromFuture(todoRepository.remove(todo)).startWith(Task.running());
  }

  Stream<Task> update(TodoEntity todo) {
    return Observable.fromFuture(todoRepository.update(todo)).startWith(Task.running());
  }

  Stream<Task> clearArchive() {
    return Observable.fromFuture(todoRepository.clearArchive()).startWith(Task.running());
  }
}
