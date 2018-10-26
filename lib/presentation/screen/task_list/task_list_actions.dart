import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/task_entity.dart';

class PerformOnTask {
  final TaskEntity task;
  final Operation operation;

  PerformOnTask({
    @required this.task,
    @required this.operation,
  })  : assert(task != null),
        assert(operation != null);
}

enum Operation { add, remove }

// class RemoveTask {
//   final TaskEntity task;

//   RemoveTask({
//     @required this.task,
//   }) : assert(task != null);
// }
