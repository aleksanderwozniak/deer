import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/app.dart';

import 'archive_list_actions.dart';
import 'archive_list_state.dart';

class ArchiveListBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  ArchiveListState get initialState => _state.value;
  Stream<ArchiveListState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<ArchiveListState>(
    seedValue: ArchiveListState(),
  );

  StreamSubscription<List<TodoEntity>> _archivedTodos;
  StreamSubscription<Task> _clearTask;

  ArchiveListBloc() {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        // example, change for your use case
        case ClearArchive:
          _onClearArchive();
          break;
        default:
          assert(false);
      }
    });

    // _archivedTodos = dependencies.archiveInteractor.todos.listen((todos) {
    _archivedTodos = dependencies.todoInteractor.finished.listen((todos) {
      _state.add(_state.value.rebuild(
        (b) => b..archivedTodos = ListBuilder(todos),
      ));
    });
  }

  void dispose() {
    _actions.close();
    _state.close();

    _archivedTodos?.cancel();
    _clearTask?.cancel();
  }

  void _onClearArchive() {
    // if (_state.value.clearTask == Task.running()) {
    //   return;
    // }

    // _clearTask?.cancel();
    // _clearTask = dependencies.archiveInteractor.clearArchive().listen((task) {
    //   _state.add(_state.value.rebuild(
    //     (b) => b..clearTask = task,
    //   ));
    // });

    // [WIP]
    if (_state.value.clearTask == Task.running()) {
      return;
    }

    _clearTask?.cancel();
    _clearTask = dependencies.todoInteractor.clearArchive().listen((task) {
      _state.add(_state.value.rebuild(
        (b) => b..clearTask = task,
      ));
    });
  }
}
