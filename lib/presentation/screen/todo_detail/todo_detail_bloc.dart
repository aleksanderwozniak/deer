import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/app.dart';

import 'todo_detail_actions.dart';
import 'todo_detail_state.dart';

class TodoDetailBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  TodoDetailState get initialState => _state.value;
  Stream<TodoDetailState> get state => _state.stream.distinct();
  final BehaviorSubject<TodoDetailState> _state;

  StreamSubscription<Task> _updateTask;

  TodoDetailBloc({@required TodoEntity todo})
      : _state = BehaviorSubject<TodoDetailState>(
          seedValue: TodoDetailState(
            todo: todo,
          ),
        ) {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        case UpdateTodo:
          _onUpdateTodo(action);
          break;
        case RestoreTodo:
          _onRestoreTodo(action);
          break;
        default:
          assert(false);
      }
    });
  }

  void dispose() {
    _actions.close();
    _state.close();

    _updateTask?.cancel();
  }

  void _onUpdateTodo(UpdateTodo action) {
    final todo = action.todo;

    _updateTask?.cancel();
    _updateTask = dependencies.todoInteractor.update(todo).listen((task) {
      _state.add(_state.value.rebuild(
        (b) => b..updateTask = task,
      ));
    });

    _state.add(_state.value.rebuild(
      (b) => b..todo = todo.toBuilder(),
    ));
  }

  void _onRestoreTodo(RestoreTodo action) {
    final todo = action.todo.rebuild((b) => b..status = TodoStatus.unassigned);
    dependencies.todoInteractor.update(todo);
  }
}
