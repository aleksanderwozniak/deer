// GENERATED CODE - DO NOT MODIFY BY HAND

part of calendar_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarState extends CalendarState {
  @override
  final DateTime selectedDate;
  @override
  final BuiltList<TodoEntity> activeTodos;
  @override
  final BuiltList<TodoEntity> archivedTodos;
  @override
  final BuiltMap<DateTime, List<TodoEntity>> activeEvents;
  @override
  final BuiltMap<DateTime, List<TodoEntity>> archivedEvents;
  @override
  final CalendarFormat calendarFormat;
  @override
  final bool calendarHeaderVisible;
  @override
  final bool todoNameHasError;
  @override
  final bool archiveVisible;

  factory _$CalendarState([void updates(CalendarStateBuilder b)]) =>
      (new CalendarStateBuilder()..update(updates)).build();

  _$CalendarState._(
      {this.selectedDate,
      this.activeTodos,
      this.archivedTodos,
      this.activeEvents,
      this.archivedEvents,
      this.calendarFormat,
      this.calendarHeaderVisible,
      this.todoNameHasError,
      this.archiveVisible})
      : super._() {
    if (selectedDate == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'selectedDate');
    }
    if (activeTodos == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'activeTodos');
    }
    if (archivedTodos == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'archivedTodos');
    }
    if (activeEvents == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'activeEvents');
    }
    if (archivedEvents == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'archivedEvents');
    }
    if (calendarFormat == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'calendarFormat');
    }
    if (calendarHeaderVisible == null) {
      throw new BuiltValueNullFieldError(
          'CalendarState', 'calendarHeaderVisible');
    }
    if (todoNameHasError == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'todoNameHasError');
    }
    if (archiveVisible == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'archiveVisible');
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
        activeTodos == other.activeTodos &&
        archivedTodos == other.archivedTodos &&
        activeEvents == other.activeEvents &&
        archivedEvents == other.archivedEvents &&
        calendarFormat == other.calendarFormat &&
        calendarHeaderVisible == other.calendarHeaderVisible &&
        todoNameHasError == other.todoNameHasError &&
        archiveVisible == other.archiveVisible;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, selectedDate.hashCode),
                                    activeTodos.hashCode),
                                archivedTodos.hashCode),
                            activeEvents.hashCode),
                        archivedEvents.hashCode),
                    calendarFormat.hashCode),
                calendarHeaderVisible.hashCode),
            todoNameHasError.hashCode),
        archiveVisible.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarState')
          ..add('selectedDate', selectedDate)
          ..add('activeTodos', activeTodos)
          ..add('archivedTodos', archivedTodos)
          ..add('activeEvents', activeEvents)
          ..add('archivedEvents', archivedEvents)
          ..add('calendarFormat', calendarFormat)
          ..add('calendarHeaderVisible', calendarHeaderVisible)
          ..add('todoNameHasError', todoNameHasError)
          ..add('archiveVisible', archiveVisible))
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

  ListBuilder<TodoEntity> _activeTodos;
  ListBuilder<TodoEntity> get activeTodos =>
      _$this._activeTodos ??= new ListBuilder<TodoEntity>();
  set activeTodos(ListBuilder<TodoEntity> activeTodos) =>
      _$this._activeTodos = activeTodos;

  ListBuilder<TodoEntity> _archivedTodos;
  ListBuilder<TodoEntity> get archivedTodos =>
      _$this._archivedTodos ??= new ListBuilder<TodoEntity>();
  set archivedTodos(ListBuilder<TodoEntity> archivedTodos) =>
      _$this._archivedTodos = archivedTodos;

  MapBuilder<DateTime, List<TodoEntity>> _activeEvents;
  MapBuilder<DateTime, List<TodoEntity>> get activeEvents =>
      _$this._activeEvents ??= new MapBuilder<DateTime, List<TodoEntity>>();
  set activeEvents(MapBuilder<DateTime, List<TodoEntity>> activeEvents) =>
      _$this._activeEvents = activeEvents;

  MapBuilder<DateTime, List<TodoEntity>> _archivedEvents;
  MapBuilder<DateTime, List<TodoEntity>> get archivedEvents =>
      _$this._archivedEvents ??= new MapBuilder<DateTime, List<TodoEntity>>();
  set archivedEvents(MapBuilder<DateTime, List<TodoEntity>> archivedEvents) =>
      _$this._archivedEvents = archivedEvents;

  CalendarFormat _calendarFormat;
  CalendarFormat get calendarFormat => _$this._calendarFormat;
  set calendarFormat(CalendarFormat calendarFormat) =>
      _$this._calendarFormat = calendarFormat;

  bool _calendarHeaderVisible;
  bool get calendarHeaderVisible => _$this._calendarHeaderVisible;
  set calendarHeaderVisible(bool calendarHeaderVisible) =>
      _$this._calendarHeaderVisible = calendarHeaderVisible;

  bool _todoNameHasError;
  bool get todoNameHasError => _$this._todoNameHasError;
  set todoNameHasError(bool todoNameHasError) =>
      _$this._todoNameHasError = todoNameHasError;

  bool _archiveVisible;
  bool get archiveVisible => _$this._archiveVisible;
  set archiveVisible(bool archiveVisible) =>
      _$this._archiveVisible = archiveVisible;

  CalendarStateBuilder();

  CalendarStateBuilder get _$this {
    if (_$v != null) {
      _selectedDate = _$v.selectedDate;
      _activeTodos = _$v.activeTodos?.toBuilder();
      _archivedTodos = _$v.archivedTodos?.toBuilder();
      _activeEvents = _$v.activeEvents?.toBuilder();
      _archivedEvents = _$v.archivedEvents?.toBuilder();
      _calendarFormat = _$v.calendarFormat;
      _calendarHeaderVisible = _$v.calendarHeaderVisible;
      _todoNameHasError = _$v.todoNameHasError;
      _archiveVisible = _$v.archiveVisible;
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
              activeTodos: activeTodos.build(),
              archivedTodos: archivedTodos.build(),
              activeEvents: activeEvents.build(),
              archivedEvents: archivedEvents.build(),
              calendarFormat: calendarFormat,
              calendarHeaderVisible: calendarHeaderVisible,
              todoNameHasError: todoNameHasError,
              archiveVisible: archiveVisible);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'activeTodos';
        activeTodos.build();
        _$failedField = 'archivedTodos';
        archivedTodos.build();
        _$failedField = 'activeEvents';
        activeEvents.build();
        _$failedField = 'archivedEvents';
        archivedEvents.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
