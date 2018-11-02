import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/dao.dart';
import 'package:tasking/data/repository/archive_repository.dart';
import 'package:tasking/data/repository/todo_repository.dart';
import 'package:tasking/domain/interactor/archive_interactor.dart';
import 'package:tasking/domain/interactor/todo_interactor.dart';

class Dependencies {
  final TodoInteractor todoInteractor;
  final ArchiveInteractor archiveInteractor;

  const Dependencies({
    @required this.todoInteractor,
    @required this.archiveInteractor,
  });

  static Dependencies standard() {
    final dao = Dao();
    final todoRepository = TodoRepository(dao: dao.todoDao);
    final archiveRepository = ArchiveRepository(dao: dao.archiveDao);

    return Dependencies(
      todoInteractor: TodoInteractor(todoRepository: todoRepository),
      archiveInteractor: ArchiveInteractor(archiveRepository: archiveRepository),
    );
  }
}
