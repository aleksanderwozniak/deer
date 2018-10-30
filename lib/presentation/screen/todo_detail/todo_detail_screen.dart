import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 16.0),
            Text('Avatar'),
            const SizedBox(height: 12.0),
            Text('Title: ${todo.name}'),
            const SizedBox(height: 8.0),
            Text('Description: ${todo.description}'),
            const SizedBox(height: 16.0),
            Text('Added on: ${todo.addedDate}'),
            const SizedBox(height: 8.0),
            Text('Due by: ${todo.dueDate}'),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
