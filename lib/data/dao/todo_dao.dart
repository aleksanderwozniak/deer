import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/data/dao/in_memory.dart';
import 'package:tasking/data/json/todo_json.dart';
import 'package:tasking/data/mapper/todo_mapper.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoDao {
  Stream<List<TodoEntity>> get all => _data.stream().map((it) => it.toList());
  Stream<List<TodoEntity>> get unassigned => _data.stream().map(
        (it) => it.where((e) => e.status == TodoStatus.unassigned).toList(),
      );
  Stream<List<TodoEntity>> get finished => _data.stream().map(
        (it) => it.where((e) => e.status == TodoStatus.finished).toList(),
      );

  final _data = InMemory<BuiltList<TodoEntity>>();

  TodoDao() {
    _loadFromDisk();
  }

  void _loadFromDisk() async {
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

  // Future<bool> save(List<TodoEntity> todos) {
  //   _data.add(BuiltList(todos));
  //   return _saveToDisk();
  // }

  Future<bool> update(TodoEntity todo) async {
    if (_data.value == null) {
      return false;
    }

    // TODO: better id system
    final current = _data.value.where((it) => it.name == todo.name);
    if (current.isEmpty) {
      return false;
    }

    final data = _data.value.toBuilder();
    data[_data.value.indexOf(current.first)] = todo;
    _data.add(data.build());

    return _saveToDisk();
  }

  Future<bool> add(TodoEntity todo) {
    final data = _data.value.toBuilder();
    data.add(todo);
    _data.add(data.build());

    return _saveToDisk();
  }

  Future<bool> remove(TodoEntity todo) {
    final data = _data.value.toBuilder();
    data.remove(todo);
    _data.add(data.build());

    return _saveToDisk();
  }

  Future<bool> clearFinished() {
    final data = _data.value.toBuilder();
    data.removeWhere((e) => e.status == TodoStatus.finished);
    _data.add(data.build());

    return _saveToDisk();
  }
}
