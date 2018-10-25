library task_entity;

import 'package:built_value/built_value.dart';

part 'task_entity.g.dart';

abstract class TaskEntity implements Built<TaskEntity, TaskEntityBuilder> {
  String get name;
  String get description;
  DateTime get addedDate;
  DateTime get dueDate;

  TaskEntity._();
  factory TaskEntity({
    String name = '',
    String description = '',
    DateTime addedDate,
    DateTime dueDate,
  }) =>
      _$TaskEntity._(
        name: name,
        description: description,
        addedDate: addedDate,
        dueDate: dueDate,
      );
}
