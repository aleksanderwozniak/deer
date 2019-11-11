library calendar_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.g.dart';

abstract class CalendarState implements Built<CalendarState, CalendarStateBuilder> {
  DateTime get selectedDate;
  BuiltList<TodoEntity> get activeTodos;
  BuiltList<TodoEntity> get archivedTodos;
  BuiltMap<DateTime, List<TodoEntity>> get activeEvents;
  BuiltMap<DateTime, List<TodoEntity>> get archivedEvents;
  CalendarFormat get calendarFormat;
  bool get calendarVisible;
  bool get todoNameHasError;
  bool get archiveVisible;
  bool get updateVisibleTodos;

  CalendarState._();
  factory CalendarState({
    DateTime selectedDate,
    BuiltList<TodoEntity> activeTodos,
    BuiltList<TodoEntity> archivedTodos,
    BuiltMap<DateTime, List<TodoEntity>> activeEvents,
    BuiltMap<DateTime, List<TodoEntity>> archivedEvents,
    CalendarFormat calendarFormat = CalendarFormat.week,
    bool calendarVisible = true,
    bool todoNameHasError = false,
    bool archiveVisible = false,
    bool updateVisibleTodos = false,
  }) =>
      _$CalendarState._(
        selectedDate: selectedDate,
        activeTodos: activeTodos ?? BuiltList(),
        archivedTodos: archivedTodos ?? BuiltList(),
        activeEvents: activeEvents ?? BuiltMap(),
        archivedEvents: archivedEvents ?? BuiltMap(),
        calendarFormat: calendarFormat,
        calendarVisible: calendarVisible,
        todoNameHasError: todoNameHasError,
        archiveVisible: archiveVisible,
        updateVisibleTodos: updateVisibleTodos,
      );
}
