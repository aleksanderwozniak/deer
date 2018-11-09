import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_actions.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_bloc.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_state.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/box.dart';
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
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      // set initialDate to tomorrow by default
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    _bloc.actions.updateDate.add(UpdateDate(date: date));
  }

  void _submit() {
    final tempTodo = TodoEntity(
      name: _nameController.text,
      description: _descriptionController.text,
      bulletPoints: BuiltList<String>.from(_bulletPointsHolder),
    );

    _bloc.actions.updateTodo.add(UpdateTodo(todo: tempTodo));
    _bloc.actions.submit.add(Submit(context: context));
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
          title: Text('Edit Todo'),
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
            children: <Widget>[
              _buildName(state),
              _buildDescription(),
              _buildBulletPoints(),
              _buildDate(state),
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

  Widget _buildName(TodoEditState state) {
    return ShadedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: TextField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          textAlign: TextAlign.center,
          style: TextStyle().copyWith(fontSize: 20.0, color: AppColors.black1),
          decoration: InputDecoration.collapsed(
            hintText: state.todoNameHasError ? 'Name can\'t be empty' : 'Todo\'s name',
            hintStyle: TextStyle().copyWith(
              color: state.todoNameHasError ? AppColors.pink1 : AppColors.grey3,
            ),
          ),
          maxLength: 50,
          maxLengthEnforced: true,
          maxLines: null,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Description',
            style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              maxLines: null,
              decoration: InputDecoration.collapsed(
                hintText: 'Todo\'s description',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints() {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Bullet points',
            style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: EditableBulletList(bulletHolder: _bulletPointsHolder),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  Widget _buildDate(TodoEditState state) {
    return ShadedBox(
      child: GestureDetector(
        onTap: _selectDate,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Due by',
              style: TextStyle().copyWith(color: AppColors.grey4, fontSize: 12.0),
            ),
            const SizedBox(height: 12.0),
            Text(
              DateFormatter.safeFormatSimple(state.todo.dueDate),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
