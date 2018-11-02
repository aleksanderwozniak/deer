import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';

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
    return Center(
      child: RoundButton(
        text: 'Pop',
        onPressed: () {
          Navigator.of(context).pop(TodoEntity(
            name: 'Updated',
            addedDate: todo.addedDate,
            description: 'Updated description',
            dueDate: todo.addedDate.add(Duration(days: 14)),
          ));
        },
      ),
    );
  }
}
