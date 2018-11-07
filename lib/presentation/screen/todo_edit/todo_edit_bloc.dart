import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

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
        case UpdateBullets:
          _onUpdateBullets(action);
          break;
        default:
          assert(false);
      }
    });
  }

  void dispose() {
    _actions.close();
    _state.close();
  }

  void _onUpdateBullets(UpdateBullets action) {
    // final text = action.text;
    // final data = _state.value.toBuilder();

    // data.todo.bulletPoints =
  }
}
