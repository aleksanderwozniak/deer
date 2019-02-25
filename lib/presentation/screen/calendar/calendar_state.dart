library calendar_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.g.dart';

abstract class CalendarState implements Built<CalendarState, CalendarStateBuilder> {
  DateTime get selectedDate;
  BuiltList<TodoEntity> get scheduledTodos;
  BuiltMap<DateTime, List<TodoEntity>> get todos;
  CalendarFormat get format;
  bool get todoNameHasError;

  CalendarState._();
  factory CalendarState({
    DateTime selectedDate,
    BuiltList<TodoEntity> scheduledTodos,
    BuiltMap<DateTime, List<TodoEntity>> todos,
    CalendarFormat format = CalendarFormat.month,
    bool todoNameHasError = false,
  }) =>
      _$CalendarState._(
        selectedDate: selectedDate,
        scheduledTodos: scheduledTodos ?? BuiltList(),
        todos: todos ?? BuiltMap(),
        format: format,
        todoNameHasError: todoNameHasError,
      );
}
