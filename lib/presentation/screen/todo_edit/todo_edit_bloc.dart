import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/utils/string_utils.dart';

import 'todo_edit_actions.dart';
import 'todo_edit_state.dart';

class TodoEditBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  TodoEditState get initialState => _state.value;
  Stream<TodoEditState> get state => _state.stream.distinct();
  final BehaviorSubject<TodoEditState> _state;

  TodoEditBloc({@required TodoEntity todo})
      : _state = BehaviorSubject<TodoEditState>(
          seedValue: TodoEditState(todo: todo),
        ) {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        case UpdateField:
          _onUpdateField(action);
          break;
        case ToggleTag:
          _onToggleTag(action);
          break;
      }
    });
  }

  void dispose() {
    _actions.close();
    _state.close();
  }

  void _onUpdateField(UpdateField action) {
    final state = _state.value.toBuilder();

    switch (action.key) {
      case FieldKey.name:
        state.todo.name = action.value;
        state.todoNameHasError = isBlank(state.todo.name);
        break;
      case FieldKey.description:
        state.todo.description = action.value;
        break;
      case FieldKey.bulletPoints:
        state.todo.bulletPoints = ListBuilder(action.value);
        break;
      case FieldKey.dueDate:
        state.todo.dueDate = action.value;
        break;
      case FieldKey.notificationDate:
        state.todo.notificationDate = action.value;
        break;
    }

    _state.add(state.build());
  }

  void _onToggleTag(ToggleTag action) {
    final tag = action.tag;
    final state = _state.value.toBuilder();
    final tags = state.todo.tags;

    if (_state.value.todo.tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }

    tags.sort();
    _state.add(state.build());
  }
}
