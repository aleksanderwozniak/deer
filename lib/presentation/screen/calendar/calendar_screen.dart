import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/dialogs.dart';
import 'package:deer/presentation/shared/widgets/dismissible.dart';
import 'package:deer/presentation/shared/widgets/label.dart';
import 'package:deer/presentation/shared/widgets/todo_adder.dart';
import 'package:deer/presentation/shared/widgets/todo_tile.dart';
import 'package:deer/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Place variables here
  CalendarBloc _bloc;
  TextEditingController _todoNameController;
  ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();
    _bloc = CalendarBloc();
    _todoNameController = TextEditingController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _onDaySelected(DateTime date) {
    _bloc.actions.add(UpdateField(field: Field.selectedDate, value: date));
  }

  void _onCalendarFormatChanged(CalendarFormat format) {
    _bloc.actions.add(UpdateField(field: Field.calendarFormat, value: format));
  }

  void _showDetails(TodoEntity todo, {bool editable = true}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo, editable: editable),
    ));
  }

  void _addTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.add, todo: todo));

    // Auto-scrolls to bottom of the ListView
    if (todo.name.trim().isNotEmpty) {
      // Because sometimes last item is skipped (see below)
      final lastItemExtent = 60.0;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _listScrollController.animateTo(
          _listScrollController.position.maxScrollExtent + lastItemExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _favoriteTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.favorite, todo: todo));
  }

  void _archiveTodo(TodoEntity todo) {
    cancelNotification(todo);
    _bloc.actions.add(PerformOnTodo(operation: Operation.archive, todo: todo));
  }

  void _onTodoAdderFormatChanged(TodoAdderFormat format) {
    _bloc.actions.add(UpdateField(
      field: Field.calendarHeaderVisible,
      value: format == TodoAdderFormat.folded,
    ));
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => RoundedAlertDialog(
            title: 'Do you want to clear the Archive?',
            actions: <Widget>[
              FlatRoundButton(
                  text: 'Yes',
                  onPressed: () {
                    Navigator.pop(context);
                    _bloc.actions.add(ClearDailyArchive());
                  }),
              FlatRoundButton(
                text: 'No',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
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

  Widget _buildUI(CalendarState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorfulApp.of(context).colors.dark),
        title: Text('Calendar View'),
        centerTitle: true,
      ),
      body: SafeArea(top: true, bottom: true, child: _buildBody(state)),
    );
  }

  Widget _buildBody(CalendarState state) {
    final children = [
      _buildCalendar(state),
      const SizedBox(height: 4.0),
    ];

    if (state.calendarFormat == CalendarFormat.month) {
      // TODO
      children.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: ColorfulApp.of(context).colors.brightGradient,
            ),
          ),
        ),
      );
    } else {
      children.addAll([
        _buildDateHeader(state),
        const SizedBox(height: 2.0),
        Expanded(child: _buildContent(state)),
      ]);
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildCalendar(CalendarState state) {
    return TableCalendar(
      onDaySelected: _onDaySelected,
      onFormatChanged: _onCalendarFormatChanged,
      events: state.activeEvents?.toMap(),
      selectedColor: ColorfulApp.of(context).colors.medium,
      todayColor: ColorfulApp.of(context).colors.pale,
      eventMarkerColor: ColorfulApp.of(context).colors.bleak,
      iconColor: ColorfulApp.of(context).colors.dark,
      initialCalendarFormat: state.calendarFormat,
      availableCalendarFormats: const [
        CalendarFormat.week,
        CalendarFormat.twoWeeks,
        CalendarFormat.month,
      ],
      headerVisible: state.calendarHeaderVisible,
      centerHeaderTitle: false,
      formatToggleVisible: true,
      formatToggleDecoration: BoxDecoration(
        border: Border.all(width: 0.0, color: ColorfulApp.of(context).colors.bleak),
        borderRadius: BorderRadius.circular(16.0),
        color: ColorfulApp.of(context).colors.pale,
      ),
      formatTogglePadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 11.0),
      formatToggleTextStyle: TextStyle().copyWith(color: AppColors.white1, fontSize: 13.0),
    );
  }

  Widget _buildDateHeader(CalendarState state) {
    final highlightStyle = TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.bold);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => _bloc.actions.add(ToggleArchive()),
          child: ShadedBox(
            child: Center(
              child: Text(
                DateFormatter.formatFull(state.selectedDate),
                style: TextStyle().copyWith(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${state.activeTodos.length}',
                style: state.archiveVisible ? TextStyle() : highlightStyle,
              ),
              Text(' / '),
              Text(
                '${state.archivedTodos.length}',
                style: state.archiveVisible ? highlightStyle : TextStyle(),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 4,
          left: 10,
          child: Text(
            '${state.archiveVisible ? 'Archive' : 'Active'}',
            style: TextStyle().copyWith(fontSize: 15.0),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(CalendarState state) {
    List<Widget> children = [];

    if (state.archiveVisible) {
      children.add(
        Expanded(child: state.archivedTodos.length == 0 ? _buildPlaceholder('Archive is empty!') : _buildArchivedList(state)),
      );
    } else {
      children.add(
        Expanded(child: state.activeTodos.length == 0 ? _buildPlaceholder('Todo list is empty!') : _buildActiveList(state)),
      );
    }

    children.add(_buildBottom(state));

    return Container(
      decoration: BoxDecoration(
        gradient: ColorfulApp.of(context).colors.brightGradient,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }

  Widget _buildBottom(CalendarState state) {
    if (state.archiveVisible) {
      return BottomButton(
        text: 'Clear',
        onPressed: _showConfirmationDialog,
      );
    } else {
      return TodoAdder(
        onAdd: _addTodo,
        onFormatChanged: _onTodoAdderFormatChanged,
        showError: state.todoNameHasError,
        todoNameController: _todoNameController,
        scheduledDate: state.selectedDate,
      );
    }
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: SingleChildScrollView(
        child: buildCentralLabel(text: text, context: context),
      ),
    );
  }

  Widget _buildActiveList(CalendarState state) {
    return ListView.builder(
        controller: _listScrollController,
        itemCount: state.activeTodos.length,
        itemBuilder: (context, index) {
          final todo = state.activeTodos[index];
          return Dismissible(
            key: Key(todo.addedDate.toIso8601String()),
            background: buildDismissibleBackground(context: context, leftToRight: true),
            secondaryBackground: buildDismissibleBackground(context: context, leftToRight: false),
            onDismissed: (_) => _archiveTodo(todo),
            child: TodoTile(
              todo: todo,
              onTileTap: () => _showDetails(todo),
              onFavoriteTap: () => _favoriteTodo(todo),
            ),
          );
        });
  }

  Widget _buildArchivedList(CalendarState state) {
    return ListView.builder(
        controller: _listScrollController,
        itemCount: state.archivedTodos.length,
        itemBuilder: (context, index) {
          final todo = state.archivedTodos[index];
          return TodoTile(
            todo: todo,
            onTileTap: () => _showDetails(todo, editable: false),
            showNotification: false,
            isFinished: true,
          );
        });
  }
}
