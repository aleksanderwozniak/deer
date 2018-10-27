import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_actions.dart';

import 'todo_list_bloc.dart';
import 'todo_list_state.dart';

class TodoListScreen extends StatefulWidget {
  final String title;

  const TodoListScreen({Key key, this.title})
      : assert(title != null),
        super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Place variables here
  TodoListBloc _bloc;
  TextEditingController _taskNameController;

  @override
  void initState() {
    super.initState();
    _bloc = TodoListBloc();
    _taskNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _removeTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.remove, todo: todo));
  }

  void _addTask(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.add, todo: todo));
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

  Widget _buildUI(TodoListState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: state.diskAccessTask == Task.running() ? _buildProgressIndicator() : _buildBody(state),
    );
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: SizedBox(
        width: 80.0,
        height: 80.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildBody(TodoListState state) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: state.todos
                .map((task) => _TaskTile(
                      task: task,
                      onTap: () => _removeTodo(task),
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
  final TodoEntity task;
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

  TodoEntity _buildTask() {
    return TodoEntity(
      name: taskNameController.text,
      addedDate: DateTime.now(),
    );
  }
}

typedef void AddTaskCallback(TodoEntity task);
