import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Place variables here
  CalendarBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CalendarBloc();
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

  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo, editable: true),
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildCalendar(state),
        const SizedBox(height: 4.0),
        Text(
          DateFormatter.formatFull(state.selectedDate),
          style: TextStyle().copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 4.0),
        Expanded(child: _buildScheduledTodos(state)),
      ],
    );
  }

  Widget _buildCalendar(CalendarState state) {
    return TableCalendar(
      onDaySelected: _onDaySelected,
      events: state.todos?.toMap(),
      selectedColor: ColorfulApp.of(context).colors.medium,
      todayColor: ColorfulApp.of(context).colors.pale,
      eventMarkerColor: ColorfulApp.of(context).colors.bleak,
    );
  }

  Widget _buildScheduledTodos(CalendarState state) {
    return ListView(
      children: state.scheduledTodos
          .map((todo) => TodoTile(
                todo: todo,
                onTileTap: () => _showDetails(todo),
              ))
          .toList(),
    );
  }
}
