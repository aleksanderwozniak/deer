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
    // _init();
  }

  // Mocks for quick testing:
  // Future<void> _init() async {
  //   await _cleanPrefs();
  //   await _loadFromDisk();
  //   final task1 = TaskEntity(name: 'Add 1', addedDate: DateTime.now());
  //   final task2 = TaskEntity(name: 'Add 2', addedDate: DateTime.now());
  //   final task3 = TaskEntity(name: 'Add 3', addedDate: DateTime.now());
  //   add(task1);
  //   add(task2);
  //   add(task3);
  //   remove(task2);
  // }

  Future<void> _loadFromDisk() async {
    var tasksFromDisk = List<TaskEntity>();

    final prefs = await SharedPreferences.getInstance();
    final amount = prefs.getInt('amountOfTasks') ?? 0;
    print('amount: $amount');
    try {
      for (var i = 0; i < amount; i++) {
        final data = prefs.getString('task$i');
        print('data: $data');
        final taskJson = TaskJson.parse(json.decode(data));
        print('taskJson: $taskJson');
        tasksFromDisk.add(TaskMapper.fromJson(taskJson));
      }
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
    final amount = data.length ?? 0;

    _cleanPrefs(instance: prefs);

    try {
      prefs.setInt('amountOfTasks', amount);
      for (var i = 0; i < amount; i++) {
        final taskJson = TaskMapper.toJson(data[i]);
        final task = json.encode(taskJson.encode());
        prefs.setString('task$i', task);
      }
    } catch (e) {
      print('SaveToDisk error: $e');
    }
  }

  Future<void> _cleanPrefs({SharedPreferences instance}) async {
    final prefs = instance ?? await SharedPreferences.getInstance();
    final amount = prefs.getInt('amountOfTasks') ?? 0;

    try {
      prefs.remove('amountOfTasks');
      for (var i = 0; i < amount; i++) {
        prefs.remove('task$i');
        print('task$i removed');
      }
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
