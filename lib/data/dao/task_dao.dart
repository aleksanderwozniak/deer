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

  void saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _data.value.toList();
    final amount = data.length ?? 0;

    _cleanPrefs(prefs);

    try {
      for (var i = 0; i < amount; i++) {
        final taskJson = TaskMapper.toJson(data[i]);
        final task = json.encode(taskJson.encode());
        prefs.setString('task$i', task);
      }
    } catch (e) {
      print('SaveToDisk error: $e');
    }
  }

  void _cleanPrefs(SharedPreferences instance) async {
    final prefs = instance ?? await SharedPreferences.getInstance();
    final amount = prefs.getInt('amountOfTasks') ?? 0;

    try {
      prefs.remove('amountOfTasks');
      for (var i = 0; i < amount; i++) {
        prefs.remove('task$i');
      }
    } catch (e) {
      print('CleanPrefs error: $e');
    }
  }

  void remove(TaskEntity task) {
    final taskBuilder = _data.value.toBuilder();
    taskBuilder.remove(task);

    _data.add(taskBuilder.build());
    saveToDisk();
  }

  void add(TaskEntity task) {
    final taskBuilder = _data.value.toBuilder();
    taskBuilder.add(task);

    _data.add(taskBuilder.build());
    saveToDisk();
  }
}
