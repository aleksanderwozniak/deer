import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/data/dao/in_memory.dart';
import 'package:tasking/data/json/task_json.dart';
import 'package:tasking/data/mapper/task_mapper.dart';
import 'package:tasking/domain/entity/task_entity.dart';

class TaskDao {
  Stream<List<TaskEntity>> get tasks => _data.stream().map((it) => it.toList());
  final _data = InMemory<BuiltList<TaskEntity>>();

  TaskDao() {
    loadFromDisk();
  }

  void loadFromDisk() async {
    var tasksFromDisk = List<TaskEntity>();

    final prefs = await SharedPreferences.getInstance();
    final amount = prefs.getInt('amountOfTasks') ?? 0;

    try {
      for (var i = 0; i < amount; i++) {
        final data = prefs.getString('task$i');
        final taskJson = TaskJson.parse(json.decode(data));

        tasksFromDisk.add(TaskMapper.fromJson(taskJson));
      }
    } catch (e) {
      print('LoadFromDisk error: $e');
    }

    final list = BuiltList(tasksFromDisk);
    _data.add(list);
    _data.seedValue = list;
  }

  void saveToDisk() async {}

  void remove() {}

  void add() {}
}
