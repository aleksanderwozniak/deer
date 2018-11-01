import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_edit_screen.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoEntity todo;

  const TodoDetailScreen({
    Key key,
    @required this.todo,
  })  : assert(todo != null),
        super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  void _edit(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoEditScreen(todo: todo),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: _buildBody(widget.todo),
    );
  }

  Widget _buildBody(TodoEntity todo) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 16.0),
              TodoAvatar(text: todo.name, isLarge: true),
              const SizedBox(height: 16.0),
              Text(
                'Title:',
                style: TextStyle().copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                todo.name,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Description:',
                style: TextStyle().copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                todo.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text('Added on: ${DateFormatter.formatSimple(todo.addedDate)}'),
              const SizedBox(height: 8.0),
              Text('Due by: ${DateFormatter.formatSimple(todo.dueDate)}'),
              const SizedBox(height: 16.0),
              Expanded(child: Container()),
              RoundButton(
                text: 'Edit',
                onPressed: () => _edit(todo),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
