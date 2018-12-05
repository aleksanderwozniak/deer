import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/domain/interactor/task.dart';
import 'package:deer/presentation/app.dart';

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
        case ClearArchive:
          _onClearArchive();
          break;
        default:
          assert(false);
      }
    });

    _archivedTodos = dependencies.todoInteractor.finished.listen((todos) {
      todos.sort((a, b) => a.finishedDate.compareTo(b.finishedDate));

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
