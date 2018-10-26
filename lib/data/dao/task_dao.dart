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
    _loadFromDisk();
  }

  Future<void> _loadFromDisk() async {
    var tasksFromDisk = List<TaskEntity>();
    final prefs = await SharedPreferences.getInstance();

    try {
      final data = prefs.getStringList('tasks');

      if (data != null) {
        tasksFromDisk = data.map((task) {
          final taskJson = TaskJson.parse(json.decode(task));
          return TaskMapper.fromJson(taskJson);
        }).toList();
      }

      print(tasksFromDisk);
    } catch (e) {
      print('LoadFromDisk error: $e');
    }

    final list = BuiltList<TaskEntity>(tasksFromDisk);
    _data.add(list);
    _data.seedValue = list;
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _data.value.toList();

    try {
      final jsonList = data.map((task) {
        final taskJson = TaskMapper.toJson(task);
        return json.encode(taskJson.encode());
      }).toList();

      prefs.setStringList('tasks', jsonList);
    } catch (e) {
      print('SaveToDisk error: $e');
    }
  }

  // Unused for now
  Future<void> _cleanPrefs({
    SharedPreferences instance,
    bool cleanAll = false,
  }) async {
    final prefs = instance ?? await SharedPreferences.getInstance();

    try {
      cleanAll ? prefs.clear() : prefs.remove('tasks');
    } catch (e) {
      print('CleanPrefs error: $e');
    }
  }

  void remove(TaskEntity task) {
    final taskBuilder = _data.value.toBuilder();
    taskBuilder.remove(task);

    _data.add(taskBuilder.build());
    _saveToDisk();
  }

  void add(TaskEntity task) {
    final taskBuilder = _data.value.toBuilder();
    taskBuilder.add(task);

    _data.add(taskBuilder.build());
    _saveToDisk();
  }
}
