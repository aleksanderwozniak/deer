import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/archive_dao.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

class ArchiveRepository {
  final ArchiveDao dao;

  ArchiveRepository({
    @required this.dao,
  }) : assert(dao != null);

  Stream<List<TodoEntity>> get todos => dao.todos;

  Future<Task> archive(TodoEntity todo) async {
    final list = await todos.first ?? List<TodoEntity>();
    list.add(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> restore(TodoEntity todo) async {
    final list = await todos.first;
    list.remove(todo);

    final result = await dao.save(list);
    return result ? Task.successful() : Task.failed();
  }

  Future<Task> clearArchive() async {
    final result = await dao.clear();
    return result ? Task.successful() : Task.failed();
  }
}
