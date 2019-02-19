// GENERATED CODE - DO NOT MODIFY BY HAND

part of calendar_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarState extends CalendarState {
  @override
  final DateTime selectedDate;

  factory _$CalendarState([void updates(CalendarStateBuilder b)]) =>
      (new CalendarStateBuilder()..update(updates)).build();

  _$CalendarState._({this.selectedDate}) : super._() {
    if (selectedDate == null) {
      throw new BuiltValueNullFieldError('CalendarState', 'selectedDate');
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
    return other is CalendarState && selectedDate == other.selectedDate;
  }

  @override
  int get hashCode {
    return $jf($jc(0, selectedDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CalendarState')
          ..add('selectedDate', selectedDate))
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

  CalendarStateBuilder();

  CalendarStateBuilder get _$this {
    if (_$v != null) {
      _selectedDate = _$v.selectedDate;
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
    final _$result = _$v ?? new _$CalendarState._(selectedDate: selectedDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
