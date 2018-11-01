import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';

class TodoEditScreen extends StatefulWidget {
  final TodoEntity todo;

  TodoEditScreen({Key key, @required this.todo})
      : assert(todo != null),
        super(key: key);

  @override
  _TodoEditScreenState createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit task'),
      ),
      body: _buildBody(widget.todo),
    );
  }

  Widget _buildBody(TodoEntity todo) {
    return Container();
  }
}
