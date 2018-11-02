// GENERATED CODE - DO NOT MODIFY BY HAND

part of archive_list_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

class _$ArchiveListState extends ArchiveListState {
  @override
  final BuiltList<TodoEntity> archivedTodos;

  factory _$ArchiveListState([void updates(ArchiveListStateBuilder b)]) =>
      (new ArchiveListStateBuilder()..update(updates)).build();

  _$ArchiveListState._({this.archivedTodos}) : super._() {
    if (archivedTodos == null) {
      throw new BuiltValueNullFieldError('ArchiveListState', 'archivedTodos');
    }
  }

  @override
  ArchiveListState rebuild(void updates(ArchiveListStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ArchiveListStateBuilder toBuilder() =>
      new ArchiveListStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArchiveListState && archivedTodos == other.archivedTodos;
  }

  @override
  int get hashCode {
    return $jf($jc(0, archivedTodos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ArchiveListState')
          ..add('archivedTodos', archivedTodos))
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

  ArchiveListStateBuilder();

  ArchiveListStateBuilder get _$this {
    if (_$v != null) {
      _archivedTodos = _$v.archivedTodos?.toBuilder();
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
  void update(void updates(ArchiveListStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ArchiveListState build() {
    _$ArchiveListState _$result;
    try {
      _$result =
          _$v ?? new _$ArchiveListState._(archivedTodos: archivedTodos.build());
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
