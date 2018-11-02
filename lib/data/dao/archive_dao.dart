import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/data/dao/in_memory.dart';
import 'package:tasking/data/json/todo_json.dart';
import 'package:tasking/data/mapper/todo_mapper.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class ArchiveDao {
  Stream<List<TodoEntity>> get todos => _data.stream().map((it) => it.toList());
  final _data = InMemory<BuiltList<TodoEntity>>();

  ArchiveDao() {
    _loadFromDisk();
  }

  void _loadFromDisk() async {
    var todosFromDisk = List<TodoEntity>();
    final prefs = await SharedPreferences.getInstance();

    try {
      final data = prefs.getStringList('todos-archive');

      if (data != null && data.length > 0) {
        todosFromDisk = data.map((task) {
          final todoJson = TodoJson.parse(json.decode(task));
          return TodoMapper.fromJson(todoJson);
        }).toList();
      }
    } catch (e) {
      print('LoadFromDisk error: $e');
    }

    final list = BuiltList<TodoEntity>(todosFromDisk);
    _data.add(list);
    _data.seedValue = list;
  }

  Future<bool> _saveToDisk() async {
    var result = false;
    final prefs = await SharedPreferences.getInstance();
    final data = await todos.first;

    try {
      final jsonList = data.map((todo) {
        final todoJson = TodoMapper.toJson(todo);
        return json.encode(todoJson.encode());
      }).toList();

      result = await prefs.setStringList('todos-archive', jsonList);
    } catch (e) {
      print('SaveToDisk error: $e');
    }

    return result;
  }

  Future<bool> save(List<TodoEntity> todos) {
    _data.add(BuiltList(todos));
    _data.seedValue = BuiltList(todos);
    return _saveToDisk();
  }

  Future<bool> clear() async {
    _data.add(BuiltList());
    _data.seedValue = BuiltList();

    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('todos-archive');
  }
}
