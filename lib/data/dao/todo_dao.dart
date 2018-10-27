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

  // Make it public if SwipeToRefresh is needed
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
    final data = _data?.value?.toList();

    try {
      final jsonList = data.map((todo) {
        final todoJson = TodoMapper.toJson(todo);
        return json.encode(todoJson.encode());
      }).toList();

      result = await prefs.setStringList('todos', jsonList);
    } catch (e) {
      print('SaveToDisk error: $e');
    }

    return result;
  }

  // Unused for now
  // Future<void> _cleanPrefs({
  //   SharedPreferences instance,
  //   bool cleanAll = false,
  // }) async {
  //   final prefs = instance ?? await SharedPreferences.getInstance();
  //
  //   try {
  //     cleanAll ? prefs.clear() : prefs.remove('todos');
  //   } catch (e) {
  //     print('CleanPrefs error: $e');
  //   }
  // }

  Future<bool> save(List<TodoEntity> todos) {
    _data.add(BuiltList(todos));
    return _saveToDisk();
  }
}
