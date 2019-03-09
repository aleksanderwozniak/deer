import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box.dart';
import 'package:deer/presentation/shared/widgets/dismissible.dart';
import 'package:deer/presentation/shared/widgets/label.dart';
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:deer/presentation/shared/widgets/todo_adder.dart';
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

  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo, editable: true),
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
        ShadedBox(
          child: Text(
            DateFormatter.formatFull(state.selectedDate),
            style: TextStyle().copyWith(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 2.0),
        Expanded(child: _buildScheduledTodos(state)),
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
      events: state.todos?.toMap(),
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

  Widget _buildScheduledTodos(CalendarState state) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorfulApp.of(context).colors.brightGradient,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: state.scheduledTodos.length == 0 ? _buildPlaceholder() : _buildListView(state),
          ),
          TodoAdder(
            onAdd: _addTodo,
            onFormatChanged: _onTodoAdderFormatChanged,
            showError: state.todoNameHasError,
            todoNameController: _todoNameController,
            scheduledDate: state.selectedDate,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: SingleChildScrollView(
        child: buildCentralLabel(text: 'Todo list is empty!', context: context),
      ),
    );
  }

  Widget _buildListView(CalendarState state) {
    return ListView.builder(
        controller: _listScrollController,
        itemCount: state.scheduledTodos.length,
        itemBuilder: (context, index) {
          final todo = state.scheduledTodos[index];
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
}
