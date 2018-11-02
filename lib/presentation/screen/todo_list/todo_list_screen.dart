import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/archive_list/archive_list_screen.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';

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
  void _archiveTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.archive, todo: todo));
  }

  void _addTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.add, todo: todo));
  }

  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo),
    ));
  }

  void _showArchive() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ArchiveListScreen(),
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
        // TODO: [WIP] go to Archive UI
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showArchive,
          ),
        ],
      ),
      body: SafeArea(top: true, bottom: true, child: _buildBody(state)),
    );
  }

  Widget _buildBody(TodoListState state) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return Dismissible(
                key: Key(todo.addedDate.toIso8601String()),
                background: _buildDismissibleBackground(leftToRight: true),
                secondaryBackground: _buildDismissibleBackground(leftToRight: false),
                onDismissed: (_) => _archiveTodo(todo),
                child: _TodoTile(
                  todo: todo,
                  onTap: () => _showDetails(todo),
                ),
              );
            },
          ),
        ),
        _TodoAdder(
          todoNameController: _taskNameController,
          onAdd: _addTodo,
        ),
      ],
    );
  }

  Widget _buildDismissibleBackground({@required bool leftToRight}) {
    final alignment = leftToRight ? Alignment.centerLeft : Alignment.centerRight;
    final colors = leftToRight ? [AppColors.grey3, AppColors.white1] : [AppColors.white1, AppColors.grey3];

    return Container(
      child: Text(
        'Done',
        style: TextStyle().copyWith(color: AppColors.white1, fontSize: 20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}

class _TodoTile extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onTap;

  const _TodoTile({
    Key key,
    @required this.todo,
    @required this.onTap,
  })  : assert(todo != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(width: 12.0),
      Expanded(
        child: Text(
          todo.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(width: 12.0),
    ];

    if (todo.name.isNotEmpty) {
      children.insertAll(1, [
        TodoAvatar(text: todo.name),
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

class _TodoAdder extends StatelessWidget {
  final TextEditingController todoNameController;
  final AddTaskCallback onAdd;

  const _TodoAdder({
    Key key,
    @required this.todoNameController,
    @required this.onAdd,
  })  : assert(todoNameController != null),
        assert(onAdd != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [BoxShadow(color: AppColors.black1, blurRadius: 4.0)],
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10.0)],
        color: AppColors.white1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      // padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: todoNameController,
              onSubmitted: (_) {
                onAdd(_buildTask());
                todoNameController.clear();
              },
            ),
          ),
          const SizedBox(width: 16.0),
          RoundButton(
            text: 'Add',
            onPressed: () {
              onAdd(_buildTask());
              todoNameController.clear();
            },
          ),
        ],
      ),
    );
  }

  TodoEntity _buildTask() {
    return TodoEntity(
      name: todoNameController.text,
      addedDate: DateTime.now(),
    );
  }
}

typedef void AddTaskCallback(TodoEntity task);
