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
  @override
  final BuiltMap<DateTime, List<TodoEntity>> todos;
  @override
  final CalendarFormat calendarFormat;
  @override
  final bool calendarHeaderVisible;
  @override
  final bool todoNameHasError;

  factory _$CalendarState([void updates(CalendarStateBuilder b)]) =>
      (new CalendarStateBuilder()..update(updates)).build();

  _$CalendarState._(
      {this.selectedDate,
      this.scheduledTodos,
      this.todos,
      this.calendarFormat,
      this.calendarHeaderVisible,
      this.todoNameHasError})
      : super._() {
    if (selectedDate == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'selectedDate');
    }
    if (scheduledTodos == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'scheduledTodos');
    }
    if (todos == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'todos');
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
        scheduledTodos == other.scheduledTodos &&
        todos == other.todos &&
        calendarFormat == other.calendarFormat &&
        calendarHeaderVisible == other.calendarHeaderVisible &&
        todoNameHasError == other.todoNameHasError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, selectedDate.hashCode), scheduledTodos.hashCode),
                    todos.hashCode),
                calendarFormat.hashCode),
            calendarHeaderVisible.hashCode),
        todoNameHasError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarState')
          ..add('selectedDate', selectedDate)
          ..add('scheduledTodos', scheduledTodos)
          ..add('todos', todos)
          ..add('calendarFormat', calendarFormat)
          ..add('calendarHeaderVisible', calendarHeaderVisible)
          ..add('todoNameHasError', todoNameHasError))
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

  MapBuilder<DateTime, List<TodoEntity>> _todos;
  MapBuilder<DateTime, List<TodoEntity>> get todos =>
      _$this._todos ??= new MapBuilder<DateTime, List<TodoEntity>>();
  set todos(MapBuilder<DateTime, List<TodoEntity>> todos) =>
      _$this._todos = todos;

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

  CalendarStateBuilder();

  CalendarStateBuilder get _$this {
    if (_$v != null) {
      _selectedDate = _$v.selectedDate;
      _scheduledTodos = _$v.scheduledTodos?.toBuilder();
      _todos = _$v.todos?.toBuilder();
      _calendarFormat = _$v.calendarFormat;
      _calendarHeaderVisible = _$v.calendarHeaderVisible;
      _todoNameHasError = _$v.todoNameHasError;
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
              scheduledTodos: scheduledTodos.build(),
              todos: todos.build(),
              calendarFormat: calendarFormat,
              calendarHeaderVisible: calendarHeaderVisible,
              todoNameHasError: todoNameHasError);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'scheduledTodos';
        scheduledTodos.build();
        _$failedField = 'todos';
        todos.build();
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
