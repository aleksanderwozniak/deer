import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/app.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:tasking/utils/string_utils.dart';
import 'package:tuple/tuple.dart';

import 'todo_list_state.dart';

class TodoListBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  TodoListState get initialState => _state.value;
  Stream<TodoListState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<TodoListState>(
    seedValue: TodoListState(),
  );

  StreamSubscription<Task> _diskAccessSubscription;
  StreamSubscription<Tuple2<String, List<TodoEntity>>> _todosSubscription;

  TodoListBloc() {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
        case PerformOnTodo:
          _onPerform(action);
          break;
        case FilterBy:
          _onFilterBy(action);
          break;
        default:
          assert(false);
      }
    });

    _todosSubscription = Observable.combineLatest2(
      dependencies.todoInteractor.filter,
      dependencies.todoInteractor.active,
      (a, b) => Tuple2<String, List<TodoEntity>>(a, b),
    ).listen((data) {
      List<TodoEntity> list = [];
      if (data.item1 == 'All') {
        list = data.item2;
      } else if (data.item1 == 'Favorite') {
        list = data.item2.where((e) => e.isFavorite).toList();
      } else {
        list = data.item2.where((e) => e.tags.contains(data.item1)).toList();
      }

      _state.add(_state.value.rebuild((b) => b..todos = ListBuilder(list)));
    });
  }

  void _onPerform(PerformOnTodo action) {
    final todo = action.todo;
    final operation = action.operation;

    switch (operation) {
      case Operation.add:
        _onAdd(todo);
        break;
      case Operation.archive:
        _onArchive(todo);
        break;
      case Operation.favorite:
        _onFavorite(todo);
        break;
    }
  }

  void _onAdd(TodoEntity todo) {
    _state.add(_state.value.rebuild((b) => b..todoNameHasError = isBlank(todo.name)));

    if (_state.value.todoNameHasError) {
      return;
    }

    _diskAccessSubscription?.cancel();
    _diskAccessSubscription = dependencies.todoInteractor.add(todo).listen((task) {
      _state.add(_state.value.rebuild((b) => b..diskAccessTask = task));
    });
  }

  void _onArchive(TodoEntity todo) {
    final todoBuilder = todo.toBuilder();
    todoBuilder.status = TodoStatus.finished;
    todoBuilder.finishedDate = DateTime.now();

    _diskAccessSubscription?.cancel();
    _diskAccessSubscription = dependencies.todoInteractor.update(todoBuilder.build()).listen((task) {
      _state.add(_state.value.rebuild((b) => b..diskAccessTask = task));
    });
  }

  void _onFavorite(TodoEntity todo) {
    final todoBuilder = todo.toBuilder();
    todoBuilder.isFavorite = !todo.isFavorite;

    _diskAccessSubscription?.cancel();
    _diskAccessSubscription = dependencies.todoInteractor.update(todoBuilder.build()).listen((task) {
      _state.add(_state.value.rebuild((b) => b..diskAccessTask = task));
    });
  }

  void _onFilterBy(FilterBy action) {
    final filter = action.filter;

    _state.add(_state.value.rebuild((b) => b..filter = filter));
    dependencies.todoInteractor.setFilter(filter);
  }

  void dispose() {
    _actions.close();
    _state.close();

    _todosSubscription?.cancel();
    _diskAccessSubscription?.cancel();
  }
}
