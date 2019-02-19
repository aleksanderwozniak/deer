library calendar_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';

part 'calendar_state.g.dart';

abstract class CalendarState implements Built<CalendarState, CalendarStateBuilder> {
  DateTime get selectedDate;
  BuiltList<TodoEntity> get scheduledTodos;

  CalendarState._();
  factory CalendarState({
    DateTime selectedDate,
    BuiltList<TodoEntity> scheduledTodos,
  }) =>
      _$CalendarState._(
        selectedDate: selectedDate,
        scheduledTodos: scheduledTodos ?? BuiltList(),
      );
}
