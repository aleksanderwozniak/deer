import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/task_entity.dart';
import 'package:tasking/presentation/app.dart';
import 'package:tasking/presentation/screen/task_list/task_list_actions.dart';

import 'task_list_state.dart';

class TaskListBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  TaskListState get initialState => _state.value;
  Stream<TaskListState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<TaskListState>(
    seedValue: TaskListState(),
  );

  StreamSubscription<List<TaskEntity>> _tasks;

  TaskListBloc() {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        case PerformOnTask:
          _onPerform(action);
          break;
        default:
          assert(false);
      }
    });

    _tasks = dependencies.taskInteractor.tasks.listen((tasks) {
      print(tasks);
      _state.add(_state.value.rebuild(
        (b) => b..tasks = ListBuilder(tasks),
      ));
    });
  }

  void _onPerform(PerformOnTask action) {
    final task = action.task;
    final operation = action.operation;

    switch (operation) {
      case Operation.add:
        dependencies.taskInteractor.add(task);
        break;
      case Operation.remove:
        dependencies.taskInteractor.remove(task);
        break;
    }
  }

  // void _onRemoveTask(RemoveTask action) {
  //   final task = action.task;

  //   dependencies.taskInteractor.remove(task);
  // }

  void dispose() {
    _actions.close();
    _state.close();

    _tasks?.cancel();
  }
}
