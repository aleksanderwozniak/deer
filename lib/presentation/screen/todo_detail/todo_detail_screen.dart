import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/screen/todo_edit/todo_edit_screen.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/box.dart';
import 'package:tasking/presentation/shared/widgets/bullet_list.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';
import 'package:tasking/utils/string_utils.dart';
import 'package:tuple/tuple.dart';

import 'todo_detail_actions.dart';
import 'todo_detail_bloc.dart';
import 'todo_detail_state.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoEntity todo;
  final bool editable;

  const TodoDetailScreen({
    Key key,
    @required this.todo,
    @required this.editable,
  })  : assert(todo != null),
        assert(editable != null),
        super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  // Place variables here
  TodoDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TodoDetailBloc(todo: widget.todo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _edit(TodoEntity todo) async {
    final updatedTodo = await Navigator.of(context).push<TodoEntity>(MaterialPageRoute(
      builder: (context) => TodoEditScreen(todo: todo),
    ));

    if (updatedTodo != null) {
      _bloc.actions.add(PerformOnTodo(operation: Operation.update, todo: updatedTodo));
    }
  }

  void _restore(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.restore, todo: todo));
    Navigator.of(context).pop();
  }

  void _delete(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.delete, todo: todo));
    Navigator.of(context).pop();
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

  Widget _buildUI(TodoDetailState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.pink4),
        centerTitle: true,
        title: Text('Todo\'s details'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(TodoDetailState state) {
    final children = [_buildName(state)];

    if (!isBlank(state.todo.description)) {
      children.add(_buildDescription(state));
    }

    if (state.todo.bulletPoints.isNotEmpty) {
      children.add(_buildBulletPoints(state));
    }

    children.addAll([
      _buildTags(),
      _buildDate(state),
      _buildFooterLabel(),
    ]);

    return SafeArea(
      top: true,
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(children: children),
          ),
          _buildBottomBox(state),
        ],
      ),
    );
  }

  Widget _buildName(TodoDetailState state) {
    return ShadedBox(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12.0),
          TodoAvatar(text: state.todo.name, isLarge: true),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              state.todo.name,
              textAlign: TextAlign.center,
              style: TextStyle().copyWith(fontSize: 20.0),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  Widget _buildDescription(TodoDetailState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Description:',
            style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.pink4),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              state.todo.description,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints(TodoDetailState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Bullet points:',
            style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.pink4),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BulletList(entries: state.todo.bulletPoints.toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Tags',
            style: TextStyle().copyWith(color: AppColors.pink4, fontSize: 12.0),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.0,
              runSpacing: 12.0,
              children: <Widget>[
                _TagChip(title: 'Tag A'),
                _TagChip(title: 'Tag C'),
                _TagChip(title: 'Tag F'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDate(TodoDetailState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Added on:',
            style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.pink4),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(width: 20.0),
              Text(
                DateFormatter.safeFormatDays(state.todo.addedDate),
              ),
              Expanded(child: const SizedBox(width: 20.0)),
              Text(
                DateFormatter.safeFormatFull(state.todo.addedDate),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Text(
            'Due by:',
            style: TextStyle().copyWith(fontSize: 12.0, color: AppColors.pink4),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(width: 20.0),
              Text(
                DateFormatter.safeFormatDays(state.todo.dueDate),
              ),
              Expanded(child: const SizedBox(width: 20.0)),
              Text(
                DateFormatter.safeFormatFull(state.todo.dueDate),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLabel() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        Center(
          child: Text(
            'Edit this Todo to add more sections',
            style: TextStyle().copyWith(
              color: AppColors.pink4,
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildBottomBox(TodoDetailState state) {
    if (widget.editable) {
      return BottomButton(
        text: 'Edit',
        onPressed: () => _edit(state.todo),
      );
    } else {
      return BottomButtonRow(
        buttonsData: [
          Tuple2('Restore', () => _restore(state.todo)),
          Tuple2('Delete', () => _delete(state.todo)),
        ],
      );
    }
  }
}

class _TagChip extends StatelessWidget {
  final String title;

  const _TagChip({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.pink4, width: 0.5),
        color: AppColors.pink1,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(title),
    );
  }
}
