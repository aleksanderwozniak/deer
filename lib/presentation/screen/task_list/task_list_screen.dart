import 'package:flutter/material.dart';

import 'task_list_actions.dart';
import 'task_list_bloc.dart';
import 'task_list_state.dart';

class TaskListScreen extends StatefulWidget {
  final String title;

  const TaskListScreen({Key key, this.title})
      : assert(title != null),
        super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Place variables here
  TaskListBloc _bloc;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _bloc = TaskListBloc();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void submit() {
    _bloc.actions.add(UpdateField(
      field: Field.username,
      value: _textController.text,
    ));
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

  Widget _buildUI(TaskListState state) {
    // Build your root view here
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Username: '),
            Text(
              state.username,
              style: TextStyle(fontSize: 20.0, color: Colors.red),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: TextField(controller: _textController),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text('submit'),
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }
}
