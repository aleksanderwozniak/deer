import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_bloc.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_state.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/editable_bullet_list.dart';

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

  List<String> _bulletPointsHolder;

  @override
  void initState() {
    super.initState();
    _bloc = TodoEditBloc(todo: widget.todo);

    _nameController = TextEditingController(text: widget.todo.name);
    _descriptionController = TextEditingController(text: widget.todo.description);

    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();

    _bulletPointsHolder = widget.todo.bulletPoints.toList();
    _dueDate = widget.todo.dueDate;
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
    // TODO: Bloc
    final updatedTodo = TodoEntity(
      name: _nameController.text,
      description: _descriptionController.text,
      bulletPoints: BuiltList.from(_bulletPointsHolder),
      status: todo.status,
      addedDate: todo.addedDate,
      // dueDate: todo.dueDate,
      dueDate: _dueDate,
    );

    Navigator.of(context).pop(updatedTodo);
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
            // padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              const SizedBox(height: 20.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: TextField(
              //     controller: _nameController,
              //     focusNode: _nameFocusNode,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //       hintText: 'Task name',
              //       labelText: 'Name',
              //     ),
              //     maxLength: 30,
              //     maxLengthEnforced: true,
              //   ),
              // ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  textAlign: TextAlign.center,
                  style: TextStyle().copyWith(fontSize: 18.0, color: AppColors.black1),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Task name',
                  ),
                  maxLength: 30,
                  maxLengthEnforced: true,
                ),
              ),
              const SizedBox(height: 12.0),
              _buildDivider(),
              const SizedBox(height: 12.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: TextField(
              //     controller: _descriptionController,
              //     focusNode: _descriptionFocusNode,
              //     maxLines: null,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //       hintText: 'Task description',
              //       labelText: 'Description',
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _descriptionController,
                  focusNode: _descriptionFocusNode,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Task description',
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              _buildDivider(),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Bullet points',
                  style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: EditableBulletList(bulletHolder: _bulletPointsHolder),
              ),
              const SizedBox(height: 24.0),
              _buildDivider(),
              const SizedBox(height: 12.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: GestureDetector(
              //     onTap: _selectDate,
              //     behavior: HitTestBehavior.opaque,
              //     child: Container(
              //       height: 60.0,
              //       alignment: Alignment.centerLeft,
              //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //       decoration: BoxDecoration(
              //         border: Border.all(color: AppColors.grey4),
              //         borderRadius: BorderRadius.circular(16.0),
              //       ),
              //       // TODO: apply DateFormat
              //       child: Text(_dueDate?.toString() ?? widget.todo.dueDate.toString()) ?? '',
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: _selectDate,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Date due',
                        style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        DateFormatter.safeFormatSimple(_dueDate),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              _buildDivider(),
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

  Widget _buildDivider() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
        ),
      ),
    );
  }
}
