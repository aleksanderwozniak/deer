// GENERATED CODE - DO NOT MODIFY BY HAND

part of todo_edit_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TodoEditState extends TodoEditState {
  @override
  final TodoEntity todo;
  @override
  final File image;
  @override
  final bool todoNameHasError;

  factory _$TodoEditState([void updates(TodoEditStateBuilder b)]) =>
      (new TodoEditStateBuilder()..update(updates)).build();

  _$TodoEditState._({this.todo, this.image, this.todoNameHasError})
      : super._() {
    if (todo == null) {
      throw new BuiltValueNullFieldError('TodoEditState', 'todo');
    }
    if (todoNameHasError == null) {
      throw new BuiltValueNullFieldError('TodoEditState', 'todoNameHasError');
    }
  }

  @override
  TodoEditState rebuild(void updates(TodoEditStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoEditStateBuilder toBuilder() => new TodoEditStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoEditState &&
        todo == other.todo &&
        image == other.image &&
        todoNameHasError == other.todoNameHasError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, todo.hashCode), image.hashCode), todoNameHasError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoEditState')
          ..add('todo', todo)
          ..add('image', image)
          ..add('todoNameHasError', todoNameHasError))
        .toString();
  }
}

class TodoEditStateBuilder
    implements Builder<TodoEditState, TodoEditStateBuilder> {
  _$TodoEditState _$v;

  TodoEntityBuilder _todo;
  TodoEntityBuilder get todo => _$this._todo ??= new TodoEntityBuilder();
  set todo(TodoEntityBuilder todo) => _$this._todo = todo;

  File _image;
  File get image => _$this._image;
  set image(File image) => _$this._image = image;

  bool _todoNameHasError;
  bool get todoNameHasError => _$this._todoNameHasError;
  set todoNameHasError(bool todoNameHasError) =>
      _$this._todoNameHasError = todoNameHasError;

  TodoEditStateBuilder();

  TodoEditStateBuilder get _$this {
    if (_$v != null) {
      _todo = _$v.todo?.toBuilder();
      _image = _$v.image;
      _todoNameHasError = _$v.todoNameHasError;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoEditState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoEditState;
  }

  @override
  void update(void updates(TodoEditStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoEditState build() {
    _$TodoEditState _$result;
    try {
      _$result = _$v ??
          new _$TodoEditState._(
              todo: todo.build(),
              image: image,
              todoNameHasError: todoNameHasError);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'todo';
        todo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoEditState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
