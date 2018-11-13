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

  FocusNode _nameFocusNode;
  FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _bloc = TodoEditBloc(todo: widget.todo);

    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      // set initialDate to tomorrow by default
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    _bloc.actions.add(UpdateField(key: FieldKey.dueDate, value: date));
  }

  void _submit(TodoEditState state) {
    if (!state.todoNameHasError) {
      Navigator.of(context).pop(state.todo);
    }
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
              _buildDescription(state),
              _buildBulletPoints(),
              _buildDate(state),
            ],
          ),
        ),
        BottomButton(
          text: 'Save',
          onPressed: () => _submit(state),
        ),
      ],
    );
  }

  Widget _buildName(TodoEditState state) {
    return ShadedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: _TextField(
          focusNode: _nameFocusNode,
          showError: state.todoNameHasError,
          value: state.todo.name,
          textAlign: TextAlign.center,
          inputAction: TextInputAction.done,
          maxLength: 50,
          maxLengthEnforced: true,
          maxLines: null,
          fontSize: 20.0,
          hint: state.todoNameHasError ? 'Name can\'t be empty' : 'Todo\'s name',
          onChanged: (value) => _bloc.actions.add(UpdateField(key: FieldKey.name, value: value)),
        ),
      ),
    );
  }

  Widget _buildDescription(TodoEditState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Description',
            style: TextStyle().copyWith(color: AppColors.pink4, fontSize: 12.0),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _TextField(
              focusNode: _descriptionFocusNode,
              maxLines: null,
              value: state.todo.description,
              hint: 'Todo\'s description',
              onChanged: (value) => _bloc.actions.add(UpdateField(key: FieldKey.description, value: value)),
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
            style: TextStyle().copyWith(color: AppColors.pink4, fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: EditableBulletList(
              initialBulletPoints: widget.todo.bulletPoints.toList(),
              onChanged: (bullets) => _bloc.actions.add(UpdateField(key: FieldKey.bulletPoints, value: bullets)),
            ),
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
              style: TextStyle().copyWith(color: AppColors.pink4, fontSize: 12.0),
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

class _TextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final TextAlign textAlign;
  final String value;
  final String hint;
  final double fontSize;
  final int maxLines;
  final int maxLength;
  final bool maxLengthEnforced;
  final bool showError;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const _TextField({
    Key key,
    this.focusNode,
    this.inputAction,
    this.textAlign = TextAlign.start,
    this.value,
    this.hint,
    this.fontSize = 14.0,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.showError = false,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  TextEditingValue _value;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController.fromValue(
      _value?.copyWith(text: widget.value) ?? TextEditingValue(text: widget.value),
    );

    controller.addListener(() {
      _value = controller.value;
      widget.onChanged(controller.value.text);
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
      child: TextField(
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: controller,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLengthEnforced,
        style: TextStyle().copyWith(
          color: AppColors.black1,
          fontSize: widget.fontSize,
        ),
        decoration: InputDecoration.collapsed(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle().copyWith(
            color: widget.showError ? AppColors.pink5 : AppColors.pink3,
            fontSize: widget.fontSize,
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
