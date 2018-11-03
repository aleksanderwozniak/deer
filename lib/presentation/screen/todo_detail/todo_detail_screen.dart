import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_edit_screen.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';
import 'package:tuple/tuple.dart';

import 'todo_detail_actions.dart';
import 'todo_detail_bloc.dart';
import 'todo_detail_state.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoEntity todo;
  final bool editable;

  const TodoDetailScreen({
    Key key,
    @required this.todo,
    @required this.editable,
  })  : assert(todo != null),
        assert(editable != null),
        super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  // Place variables here
  TodoDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TodoDetailBloc(todo: widget.todo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _edit(TodoEntity todo) async {
    final updatedTodo = await Navigator.of(context).push<TodoEntity>(MaterialPageRoute(
      builder: (context) => TodoEditScreen(todo: todo),
    ));

    if (updatedTodo != null) {
      _bloc.actions.add(PerformOnTodo(operation: Operation.update, todo: updatedTodo));
    }
  }

  void _restore(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.restore, todo: todo));
    Navigator.of(context).pop();
  }

  void _delete(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.delete, todo: todo));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _bloc.initialState,
      stream: _bloc.state,
      builder: (context, snapshot) {
        return _buildUI(snapshot.data);
      },
    );
  }

  Widget _buildUI(TodoDetailState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        title: Text('Task details'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(TodoDetailState state) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: <Widget>[
                const SizedBox(height: 16.0),
                TodoAvatar(text: state.todo.name, isLarge: true),
                const SizedBox(height: 16.0),
                Text(
                  'Title:',
                  textAlign: TextAlign.center,
                  style: TextStyle().copyWith(fontSize: 20.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  state.todo.name,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Description:',
                  textAlign: TextAlign.center,
                  style: TextStyle().copyWith(fontSize: 20.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  state.todo.description,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Added on: ${DateFormatter.formatSimple(state.todo.addedDate)}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Due by: ${DateFormatter.formatSimple(state.todo.dueDate)}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
          _buildBottom(state),
        ],
      ),
    );
  }

  Widget _buildBottom(TodoDetailState state) {
    if (widget.editable) {
      return BottomButton(
        text: 'Edit',
        onPressed: () => _edit(state.todo),
      );
    } else {
      return BottomButtonRow(
        buttonsData: [
          Tuple2('Restore', () => _restore(state.todo)),
          Tuple2('Delete', () => _delete(state.todo)),
        ],
      );
    }
  }
}
