import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/task_entity.dart';
import 'package:tasking/presentation/screen/task_list/task_list_actions.dart';

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
  TextEditingController _taskNameController;

  @override
  void initState() {
    super.initState();
    _bloc = TaskListBloc();
    _taskNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _removeTask(TaskEntity task) {
    _bloc.actions.add(PerformOnTask(operation: Operation.remove, task: task));
  }

  void _addTask(TaskEntity task) {
    _bloc.actions.add(PerformOnTask(operation: Operation.add, task: task));
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
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: state.tasks
                .map((task) => _TaskTile(
                      task: task,
                      onTap: () => _removeTask(task),
                    ))
                .toList(),
          ),
        ),
        _TaskAdder(
          taskNameController: _taskNameController,
          onAdd: _addTask,
        ),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;

  const _TaskTile({
    Key key,
    @required this.task,
    @required this.onTap,
  })  : assert(task != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _TaskAdder extends StatelessWidget {
  final TextEditingController taskNameController;
  final AddTaskCallback onAdd;

  const _TaskAdder({
    Key key,
    @required this.taskNameController,
    @required this.onAdd,
  })  : assert(taskNameController != null),
        assert(onAdd != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: taskNameController,
              onSubmitted: (_) {
                onAdd(_buildTask());
                taskNameController.clear();
              },
            ),
          ),
          const SizedBox(width: 16.0),
          FlatButton(
            child: Text('Add'),
            color: Colors.green[300],
            onPressed: () => onAdd(_buildTask()),
          ),
        ],
      ),
    );
  }

  TaskEntity _buildTask() {
    return TaskEntity(
      name: taskNameController.text,
      addedDate: DateTime.now(),
    );
  }
}

typedef void AddTaskCallback(TaskEntity task);
