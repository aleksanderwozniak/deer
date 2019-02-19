// GENERATED CODE - DO NOT MODIFY BY HAND

part of calendar_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarState extends CalendarState {
  @override
  final DateTime selectedDate;
  @override
  final BuiltList<TodoEntity> scheduledTodos;

  factory _$CalendarState([void updates(CalendarStateBuilder b)]) =>
      (new CalendarStateBuilder()..update(updates)).build();

  _$CalendarState._({this.selectedDate, this.scheduledTodos}) : super._() {
    if (selectedDate == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'selectedDate');
    }
    if (scheduledTodos == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'scheduledTodos');
    }
  }

  @override
  CalendarState rebuild(void updates(CalendarStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CalendarStateBuilder toBuilder() => new CalendarStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalendarState &&
        selectedDate == other.selectedDate &&
        scheduledTodos == other.scheduledTodos;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selectedDate.hashCode), scheduledTodos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarState')
          ..add('selectedDate', selectedDate)
          ..add('scheduledTodos', scheduledTodos))
        .toString();
  }
}

class CalendarStateBuilder
    implements Builder<CalendarState, CalendarStateBuilder> {
  _$CalendarState _$v;

  DateTime _selectedDate;
  DateTime get selectedDate => _$this._selectedDate;
  set selectedDate(DateTime selectedDate) =>
      _$this._selectedDate = selectedDate;

  ListBuilder<TodoEntity> _scheduledTodos;
  ListBuilder<TodoEntity> get scheduledTodos =>
      _$this._scheduledTodos ??= new ListBuilder<TodoEntity>();
  set scheduledTodos(ListBuilder<TodoEntity> scheduledTodos) =>
      _$this._scheduledTodos = scheduledTodos;

  CalendarStateBuilder();

  CalendarStateBuilder get _$this {
    if (_$v != null) {
      _selectedDate = _$v.selectedDate;
      _scheduledTodos = _$v.scheduledTodos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CalendarState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CalendarState;
  }

  @override
  void update(void updates(CalendarStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CalendarState build() {
    _$CalendarState _$result;
    try {
      _$result = _$v ??
          new _$CalendarState._(
              selectedDate: selectedDate,
              scheduledTodos: scheduledTodos.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'scheduledTodos';
        scheduledTodos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CalendarState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
