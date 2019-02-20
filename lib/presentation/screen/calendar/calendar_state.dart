library calendar_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

part 'calendar_state.g.dart';

abstract class CalendarState implements Built<CalendarState, CalendarStateBuilder> {
  DateTime get selectedDate;
  BuiltList<TodoEntity> get scheduledTodos;
  EventList<TodoEntity> get todos;

  CalendarState._();
  factory CalendarState({
    DateTime selectedDate,
    BuiltList<TodoEntity> scheduledTodos,
    EventList<TodoEntity> todos,
  }) =>
      _$CalendarState._(
        selectedDate: selectedDate,
        scheduledTodos: scheduledTodos ?? BuiltList(),
        todos: todos ?? EventList(),
      );
}
