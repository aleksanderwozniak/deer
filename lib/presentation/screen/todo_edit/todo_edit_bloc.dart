import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/utils/string_utils.dart';

import 'todo_edit_actions.dart';
import 'todo_edit_state.dart';

class TodoEditBloc {
  final actions = Actions();

  TodoEditState get initialState => _state.value;
  Stream<TodoEditState> get state => _state.stream.distinct();
  final BehaviorSubject<TodoEditState> _state;

  TodoEditBloc({@required TodoEntity todo})
      : _state = BehaviorSubject<TodoEditState>(
          seedValue: TodoEditState(todo: todo),
        ) {
    actions._updateField.stream.listen(_onUpdateField);
    actions._updateTodo.stream.listen(_onUpdateTodo);
    actions._submit.stream.listen(_onSubmit);
  }

  void dispose() {
    actions._dispose();
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
      case FieldKey.dueDate:
        state.todo.dueDate = action.value;
        break;
    }

    _state.add(state.build());
  }

  void _onUpdateTodo(UpdateTodo action) {
    final state = _state.value.toBuilder();

    state.todo.name = action.todo.name;
    state.todo.description = action.todo.description;
    state.todo.bulletPoints = action.todo.bulletPoints.toBuilder();
    state.todoNameHasError = isBlank(state.todo.name);

    _state.add(state.build());
  }

  void _onSubmit(Submit action) {
    if (_state.value.todoNameHasError) {
      return;
    }

    final context = action.context;
    Navigator.of(context).pop(_state.value.todo);
  }
}

class Actions {
  Sink<UpdateField> get updateField => _updateField;
  final _updateField = StreamController<UpdateField>();

  Sink<UpdateTodo> get updateTodo => _updateTodo;
  final _updateTodo = StreamController<UpdateTodo>();

  Sink<Submit> get submit => _submit;
  final _submit = StreamController<Submit>();

  void _dispose() {
    _updateField.close();
    _updateTodo.close();
    _submit.close();
  }
}
