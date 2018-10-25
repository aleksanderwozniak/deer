import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/task_entity.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(TaskListState state) {
    return ListView(
      children: state.tasks.map((task) => _buildTile(task)).toList(),
    );
  }

  Widget _buildTile(TaskEntity task) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.0,
            color: Colors.grey[800],
          ),
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(task.name),
    );
  }
}
