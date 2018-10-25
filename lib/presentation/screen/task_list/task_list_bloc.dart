import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/task_entity.dart';
import 'package:tasking/presentation/app.dart';

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
        // example, change for your use case
        // case UpdateField:
        // _onUpdateField(action);
        // break;
        default:
          assert(false);
      }
    });

    _tasks = dependencies.taskInteractor.tasks.listen((tasks) {
      _state.add(_state.value.rebuild(
        (b) => b..tasks = ListBuilder(tasks),
      ));
    });
  }

  void dispose() {
    _actions.close();
    _state.close();

    _tasks?.cancel();
  }
}
