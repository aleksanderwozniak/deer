import 'package:tasking/data/json/task_json.dart';
import 'package:tasking/domain/entity/task_entity.dart';

class TaskMapper {
  TaskMapper._();

  static TaskJson toJson(TaskEntity task) {
    return TaskJson(
      name: task.name,
      description: task.description,
      addedDate: task.addedDate,
      dueDate: task.dueDate,
    );
  }

  static TaskEntity fromJson(TaskJson json) {
    return TaskEntity(
      name: json.name,
      description: json.description,
      addedDate: json.addedDate,
      dueDate: json.dueDate,
    );
  }
}
