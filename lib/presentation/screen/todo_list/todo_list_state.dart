library todo_list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

part 'todo_list_state.g.dart';

abstract class TodoListState implements Built<TodoListState, TodoListStateBuilder> {
  BuiltList<TodoEntity> get todos;

  TodoListState._();
  factory TodoListState({
    BuiltList<TodoEntity> todos,
  }) =>
      _$TodoListState._(
        todos: todos ?? BuiltList(),
      );
}
