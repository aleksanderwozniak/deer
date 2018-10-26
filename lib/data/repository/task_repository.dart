import 'package:flutter/foundation.dart';
import 'package:tasking/data/dao/task_dao.dart';
import 'package:tasking/domain/entity/task_entity.dart';

class TaskRepository {
  final TaskDao taskDao;

  TaskRepository({
    @required this.taskDao,
  }) : assert(taskDao != null);

  Stream<List<TaskEntity>> get tasks => taskDao.tasks;

  void add(TaskEntity task) {
    taskDao.add(task);
  }

  void remove(TaskEntity task) {
    taskDao.remove(task);
  }
}
