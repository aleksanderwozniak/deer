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
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  FocusNode _nameFocusNode;
  FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.todo.name);
    _descriptionController = TextEditingController(text: widget.todo.description);

    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  void _submit() {
    final updatedTodo = TodoEntity(
      name: _nameController.text,
      addedDate: widget.todo.addedDate,
      description: _descriptionController.text,
      dueDate: widget.todo.dueDate,
    );

    Navigator.of(context).pop(updatedTodo);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _nameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit task'),
        ),
        body: _buildBody(widget.todo),
      ),
    );
  }

  Widget _buildBody(TodoEntity todo) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  hintText: 'Task name',
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  hintText: 'Task description',
                ),
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        RoundButton(
          text: 'Save',
          onPressed: _submit,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
