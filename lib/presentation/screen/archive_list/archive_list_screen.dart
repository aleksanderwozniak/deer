import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/domain/interactor/task.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/screen/archive_list/archive_list_actions.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/tile.dart';

import 'archive_list_bloc.dart';
import 'archive_list_state.dart';

class ArchiveListScreen extends StatefulWidget {
  @override
  _ArchiveListScreenState createState() => _ArchiveListScreenState();
}

class _ArchiveListScreenState extends State<ArchiveListScreen> {
  // Place variables here
  ArchiveListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ArchiveListBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo, editable: false),
    ));
  }

  void _clearArchive() {
    _bloc.actions.add(ClearArchive());
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

  Widget _buildUI(ArchiveListState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorfulApp.of(context).colors.dark),
        centerTitle: true,
        title: Text('Archive'),
      ),
      body: state.clearTask != Task.running() ? _buildBody(state) : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBody(ArchiveListState state) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Container(
        decoration: BoxDecoration(gradient: ColorfulApp.of(context).colors.brightGradient),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: state.archivedTodos.length,
                itemBuilder: (context, index) {
                  final todo = state.archivedTodos[index];
                  return TodoTile(
                    todo: todo,
                    onTap: () => _showDetails(todo),
                  );
                },
              ),
            ),
            BottomButton(
              text: 'Clear',
              onPressed: _clearArchive,
            ),
          ],
        ),
      ),
    );
  }
}
