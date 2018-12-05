import 'dart:async';

import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/domain/interactor/task.dart';
import 'package:deer/presentation/app.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

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
        case PerformOnTodo:
          _onPerform(action);
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

  void _onPerform(PerformOnTodo action) {
    switch (action.operation) {
      case Operation.update:
        _onUpdateTodo(action.todo);
        break;
      case Operation.restore:
        _onRestoreTodo(action.todo);
        break;
      case Operation.cleanRestore:
        _onCleanRestoreTodo(action.todo);
        break;
      case Operation.delete:
        _onDeleteTodo(action.todo);
        break;
      default:
        assert(false);
    }
  }

  void _onUpdateTodo(TodoEntity todo) {
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

  void _onCleanRestoreTodo(TodoEntity todo) {
    final updatedTodo = todo.rebuild(
      (b) => b
        ..status = TodoStatus.active
        ..notificationDate = null
        ..finishedDate = null,
    );

    dependencies.todoInteractor.update(updatedTodo);
  }

  void _onRestoreTodo(TodoEntity todo) {
    final updatedTodo = todo.rebuild(
      (b) => b
        ..status = TodoStatus.active
        ..finishedDate = null,
    );

    dependencies.todoInteractor.update(updatedTodo);
  }

  void _onDeleteTodo(TodoEntity todo) {
    dependencies.todoInteractor.remove(todo);
  }
}
