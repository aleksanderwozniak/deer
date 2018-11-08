import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_screen.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/resources.dart';
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

  final _colorsMock = [Colors.blueAccent, Colors.redAccent, Colors.greenAccent];

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
              children: <Widget>[
                _buildSection(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 12.0),
                      TodoAvatar(text: state.todo.name, isLarge: true),
                      const SizedBox(height: 16.0),
                      Text(
                        state.todo.name,
                        textAlign: TextAlign.center,
                        style: TextStyle().copyWith(fontSize: 20.0),
                      ),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                ),
                // _buildDivider(),
                _buildSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Description:',
                        style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.grey4),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          state.todo.description,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                // _buildDivider(),
                _buildSection(
                  child: Column(
                    // TODO: Refactor this
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Bullet points:',
                        style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.grey4),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.todo.bulletPoints.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.black1,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      entry,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // _buildDivider(),
                _buildSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Added on:',
                        style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.grey4),
                      ),
                      Text(
                        DateFormatter.safeFormatSimple(state.todo.addedDate),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        'Due by:',
                        style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.grey4),
                      ),
                      Text(
                        DateFormatter.safeFormatSimple(state.todo.dueDate),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottom(state),
        ],
      ),
    );
  }

  Widget _buildSection({@required Widget child}) {
    _colorsMock.shuffle();

    return Container(
      // decoration: BoxDecoration(
      //   // color: _colorsMock.first,
      //   border: BorderDirectional(top: BorderSide()),
      // ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2.0)],
        // boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4.0)],
        color: AppColors.white1,
        // color: _colorsMock.first,
        // color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: child,
    );
  }

  Widget _buildDivider() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
        ),
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
