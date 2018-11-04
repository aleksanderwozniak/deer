import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/shared/resources.dart';
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
  DateTime _dueDate;
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

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    // TODO: Bloc
    setState(() {
      _dueDate = date;
    });
  }

  void _submit() {
    final updatedTodo = TodoEntity(
      name: _nameController.text,
      addedDate: widget.todo.addedDate,
      description: _descriptionController.text,
      dueDate: _dueDate ?? widget.todo.dueDate,
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
              const SizedBox(height: 12.0),
              GestureDetector(
                onTap: _selectDate,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 60.0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey4),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  // TODO: apply DateFormat
                  child: Text(_dueDate?.toString() ?? widget.todo.dueDate.toString()) ?? '',
                ),
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
        BottomButton(
          text: 'Save',
          onPressed: _submit,
        ),
      ],
    );
  }
}
