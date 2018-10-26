import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/data/dao/in_memory.dart';
import 'package:tasking/data/json/todo_json.dart';
import 'package:tasking/data/mapper/todo_mapper.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoDao {
  Stream<List<TodoEntity>> get todos => _data.stream().map((it) => it.toList());
  final _data = InMemory<BuiltList<TodoEntity>>();

  TodoDao() {
    _loadFromDisk();
  }

  Future<void> _loadFromDisk() async {
    var todosFromDisk = List<TodoEntity>();
    final prefs = await SharedPreferences.getInstance();

    try {
      final data = prefs.getStringList('todos');

      if (data != null) {
        todosFromDisk = data.map((task) {
          final todoJson = TodoJson.parse(json.decode(task));
          return TodoMapper.fromJson(todoJson);
        }).toList();
      }

      print(todosFromDisk);
    } catch (e) {
      print('LoadFromDisk error: $e');
    }

    final list = BuiltList<TodoEntity>(todosFromDisk);
    _data.add(list);
    _data.seedValue = list;
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _data.value.toList();

    try {
      final jsonList = data.map((todo) {
        final todoJson = TodoMapper.toJson(todo);
        return json.encode(todoJson.encode());
      }).toList();

      prefs.setStringList('todos', jsonList);
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
      cleanAll ? prefs.clear() : prefs.remove('todos');
    } catch (e) {
      print('CleanPrefs error: $e');
    }
  }

  void remove(TodoEntity todo) {
    final todoBuilder = _data.value.toBuilder();
    todoBuilder.remove(todo);

    _data.add(todoBuilder.build());
    _saveToDisk();
  }

  void add(TodoEntity todo) {
    final todoBuilder = _data.value.toBuilder();
    todoBuilder.add(todo);

    _data.add(todoBuilder.build());
    _saveToDisk();
  }
}
