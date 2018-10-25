import 'package:flutter/foundation.dart';
import 'package:tasking/data/repository/task_repository.dart';
import 'package:tasking/domain/entity/task_entity.dart';

class TaskInteractor {
  final TaskRepository taskRepository;

  TaskInteractor({
    @required this.taskRepository,
  }) : assert(taskRepository != null);

  Stream<List<TaskEntity>> get tasks => taskRepository.tasks;

  void add(TaskEntity task) {
    taskRepository.add(task);
  }

  void remove(TaskEntity task) {
    taskRepository.remove(task);
  }
}
