import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/todo_dao.dart';
import 'package:tasking/data/repository/todo_repository.dart';
import 'package:tasking/domain/interactor/todo_interactor.dart';

class Dependencies {
  final TodoInteractor todoInteractor;

  const Dependencies({
    @required this.todoInteractor,
  });

  static Dependencies standard() {
    final todoRepository = TodoRepository(dao: TodoDao());

    return Dependencies(
      todoInteractor: TodoInteractor(todoRepository: todoRepository),
    );
  }
}
