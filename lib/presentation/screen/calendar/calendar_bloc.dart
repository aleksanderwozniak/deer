import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import 'calendar_actions.dart';
import 'calendar_state.dart';

class CalendarBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  CalendarState get initialState => _state.value;
  Stream<CalendarState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<CalendarState>(
    seedValue: CalendarState(
      selectedDate: DateTime.now(),
    ),
  );

  CalendarBloc() {
    _actions.stream.listen((action) {
      switch (action.runtimeType) {
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

  void _onUpdateField(UpdateField action) {
    final state = _state.value.toBuilder();

    switch (action.field) {
      case Field.selectedDate:
        state.selectedDate = action.value;
        break;
      case Field.scheduledTodos:
        state.scheduledTodos = ListBuilder(action.value);
        break;
    }

    _state.add(state.build());
  }
}
