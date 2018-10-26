import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/task_dao.dart';
import 'package:tasking/data/repository/task_repository.dart';
import 'package:tasking/domain/interactor/task_interactor.dart';

class Dependencies {
  final TaskInteractor taskInteractor;

  const Dependencies({
    @required this.taskInteractor,
  });

  static Dependencies standard() {
    final taskRepository = TaskRepository(taskDao: TaskDao());

    return Dependencies(
      taskInteractor: TaskInteractor(taskRepository: taskRepository),
    );
  }
}
