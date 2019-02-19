library calendar_state;

import 'package:built_value/built_value.dart';

part 'calendar_state.g.dart';

abstract class CalendarState implements Built<CalendarState, CalendarStateBuilder> {
  DateTime get selectedDate;

  CalendarState._();
  factory CalendarState({
    DateTime selectedDate,
  }) =>
      _$CalendarState._(
        selectedDate: selectedDate,
      );
}
