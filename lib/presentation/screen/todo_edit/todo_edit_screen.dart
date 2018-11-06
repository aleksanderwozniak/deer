import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_actions.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_bloc.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_state.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/bullet_list_edit.dart';
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
  TodoEditBloc _bloc;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  DateTime _dueDate;
  FocusNode _nameFocusNode;
  FocusNode _descriptionFocusNode;

  List<String> _bullets;
  bool _showBullets = false;

  List<String> listholder;

  @override
  void initState() {
    super.initState();
    _bloc = TodoEditBloc(todo: widget.todo);

    _nameController = TextEditingController(text: widget.todo.name);
    _descriptionController = TextEditingController(text: widget.todo.description);

    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();

    _showBullets = false;
    _bullets = widget.todo.bulletPoints.toList();

    listholder = List();
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

  void _submit(TodoEntity todo) {
    // final updatedTodo = TodoEntity(
    //   name: _nameController.text,
    //   description: _descriptionController.text,
    //   bulletPoints: BuiltList.from(_bullets),
    //   status: widget.todo.status ?? TodoStatus.unassigned,
    //   addedDate: widget.todo.addedDate,
    //   dueDate: _dueDate ?? widget.todo.dueDate,
    // );

    // [WIP]
    final updatedTodo = TodoEntity(
      name: _nameController.text,
      description: _descriptionController.text,
      // bulletPoints: todo.bulletPoints,
      bulletPoints: BuiltList.from(listholder),
      status: todo.status,
      addedDate: todo.addedDate,
      dueDate: todo.dueDate,
    );

    Navigator.of(context).pop(updatedTodo);
  }

  void _mergeBullets(String result) {
    // setState(() {
    //   _bullets.add(result);
    // });
    _bloc.actions.add(UpdateBullets(text: result));
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

  Widget _buildUI(TodoEditState state) {
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
        body: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(TodoEditState state) {
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
              const SizedBox(height: 12.0),
              // _buildBulletPoints(),
              BulletListEdit(listholder: listholder),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
        BottomButton(
          text: 'Save',
          onPressed: () => _submit(state.todo),
        ),
      ],
    );
  }

  // Widget _buildBulletPoints() {
  //   final children = _bullets.map((entry) {
  //     return _buildRow(entry);
  //   }).toList();

  //   children.add(_buildRow('', autofocus: _showBullets));

  //   if (!_showBullets) {
  //     setState(() {
  //       _showBullets = true;
  //     });
  //   }

  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: children,
  //   );
  // }

  // Widget _buildRow(String text, {bool autofocus = false}) {
  //   return Row(
  //     children: <Widget>[
  //       const SizedBox(width: 20.0),
  //       Container(
  //         width: 8.0,
  //         height: 8.0,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: AppColors.black1,
  //         ),
  //       ),
  //       const SizedBox(width: 12.0),
  //       Expanded(
  //         child: TextField(
  //           autofocus: autofocus,
  //           controller: TextEditingController(text: text),
  //           onSubmitted: (result) => _mergeBullets(result),
  //         ),
  //       ),
  //       const SizedBox(width: 20.0),
  //     ],
  //   );
  // }
}
