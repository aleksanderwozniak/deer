import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/data/repository/archive_repository.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';

class ArchiveInteractor {
  final ArchiveRepository archiveRepository;

  ArchiveInteractor({
    @required this.archiveRepository,
  }) : assert(archiveRepository != null);

  Stream<List<TodoEntity>> get todos => archiveRepository.todos;

  Stream<Task> archive(TodoEntity todo) {
    return Observable.fromFuture(archiveRepository.archive(todo)).startWith(Task.running());
  }

  Stream<Task> restore(TodoEntity todo) {
    return Observable.fromFuture(archiveRepository.restore(todo)).startWith(Task.running());
  }

  Stream<Task> clearArchive() {
    return Observable.fromFuture(archiveRepository.clearArchive()).startWith(Task.running());
  }
}
