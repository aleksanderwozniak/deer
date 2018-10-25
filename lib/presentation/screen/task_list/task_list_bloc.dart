import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'task_list_actions.dart';
import 'task_list_state.dart';

class TaskListBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  TaskListState get initialState => _state.value;
  Stream<TaskListState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<TaskListState>(
    seedValue: TaskListState(
      username: 'alex',
    ),
  );

  TaskListBloc() {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        // example, change for your use case
        case UpdateField:
          _onUpdateField(action);
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

  // example
  void _onUpdateField(UpdateField action) {
    // One way to use BuiltValue is to convert the immutable object to a builder
    // It allows to update some attributes on the object, then call `build()` to make a new immutable object
    // `_state` is the subject, and because it has always a value (because it's init with seedValue), it's safe to always
    // call `_state.value` to get the current value
    final state = _state.value.toBuilder();

    switch (action.field) {
      case Field.username:
        state.username = action.value;
        break;
    }

    // Once builder is updated, push a new immutable state to the subject (= to the stream)
    // At that point, `StreamBuilder` in the login screen will rebuild with the new state
    _state.add(state.build());
  }
}
