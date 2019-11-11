// GENERATED CODE - DO NOT MODIFY BY HAND

part of archive_list_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArchiveListState extends ArchiveListState {
  @override
  final BuiltList<TodoEntity> archivedTodos;
  @override
  final Task clearTask;

  factory _$ArchiveListState(
          [void Function(ArchiveListStateBuilder) updates]) =>
      (new ArchiveListStateBuilder()..update(updates)).build();

  _$ArchiveListState._({this.archivedTodos, this.clearTask}) : super._() {
    if (archivedTodos == null) {
      throw new BuiltValueNullFieldError('ArchiveListState', 'archivedTodos');
    }
    if (clearTask == null) {
      throw new BuiltValueNullFieldError('ArchiveListState', 'clearTask');
    }
  }

  @override
  ArchiveListState rebuild(void Function(ArchiveListStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArchiveListStateBuilder toBuilder() =>
      new ArchiveListStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArchiveListState &&
        archivedTodos == other.archivedTodos &&
        clearTask == other.clearTask;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, archivedTodos.hashCode), clearTask.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ArchiveListState')
          ..add('archivedTodos', archivedTodos)
          ..add('clearTask', clearTask))
        .toString();
  }
}

class ArchiveListStateBuilder
    implements Builder<ArchiveListState, ArchiveListStateBuilder> {
  _$ArchiveListState _$v;

  ListBuilder<TodoEntity> _archivedTodos;
  ListBuilder<TodoEntity> get archivedTodos =>
      _$this._archivedTodos ??= new ListBuilder<TodoEntity>();
  set archivedTodos(ListBuilder<TodoEntity> archivedTodos) =>
      _$this._archivedTodos = archivedTodos;

  Task _clearTask;
  Task get clearTask => _$this._clearTask;
  set clearTask(Task clearTask) => _$this._clearTask = clearTask;

  ArchiveListStateBuilder();

  ArchiveListStateBuilder get _$this {
    if (_$v != null) {
      _archivedTodos = _$v.archivedTodos?.toBuilder();
      _clearTask = _$v.clearTask;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArchiveListState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ArchiveListState;
  }

  @override
  void update(void Function(ArchiveListStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ArchiveListState build() {
    _$ArchiveListState _$result;
    try {
      _$result = _$v ??
          new _$ArchiveListState._(
              archivedTodos: archivedTodos.build(), clearTask: clearTask);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'archivedTodos';
        archivedTodos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ArchiveListState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
