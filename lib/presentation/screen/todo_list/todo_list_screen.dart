import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:tasking/presentation/widgets/todo_avatar.dart';

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

  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo),
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
            children: state.todos.map((task) {
              return Dismissible(
                key: Key(task.addedDate.toIso8601String()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  _removeTodo(task);

                  // Scaffold.of(contextx).showSnackBar(SnackBar(
                  // content: Text('${task.name} removed'),
                  // ));
                },
                child: _TaskTile(
                  task: task,
                  onTap: () => _showDetails(task),
                ),
              );
            }).toList(),
          ),
        ),
        _TaskAdder(
          taskNameController: _taskNameController,
          onAdd: _addTask,
        ),
      ],
    );
  }

  Widget _buildBodyStack(TodoListState state) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ListView(
            children: state.todos
                .map((task) => _TaskTile(
                      task: task,
                      // onTap: () => _removeTodo(task),
                      onTap: () => _showDetails(task),
                    ))
                .toList(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _TaskAdder(
            taskNameController: _taskNameController,
            onAdd: _addTask,
          ),
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
    final children = [
      const SizedBox(width: 12.0),
      Text(task.name),
      const SizedBox(width: 12.0),
    ];

    if (task.name.isNotEmpty) {
      children.insertAll(1, [
        TodoAvatar(text: task.name),
        const SizedBox(width: 8.0),
      ]);
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: children,
        ),
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
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: Colors.grey[700]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 12.0),
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
              onPressed: () {
                onAdd(_buildTask());
                taskNameController.clear();
              },
            ),
          ],
        ),
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
