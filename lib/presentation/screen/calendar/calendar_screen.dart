import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

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
  void _onDayPressed(DateTime date, _) {
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
        Flexible(
          child: _buildCalendarCarousel(state),
          flex: 3,
          fit: FlexFit.tight,
        ),
        Text(
          DateFormatter.formatFull(state.selectedDate),
          style: TextStyle().copyWith(fontSize: 18.0),
        ),
        Flexible(
          child: state.scheduledTodos.isNotEmpty
              ? _buildScheduledTodos(state)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('No scheduled Todos for this day'),
                ),
          fit: FlexFit.loose,
        ),
      ],
    );
  }

  Widget _buildCalendarCarousel(CalendarState state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        markedDatesMap: state.todos,
        onDayPressed: _onDayPressed,
        selectedDateTime: state.selectedDate,
        iconColor: ColorfulApp.of(context).colors.dark,
        todayButtonColor: ColorfulApp.of(context).colors.pale,
        selectedDayButtonColor: ColorfulApp.of(context).colors.medium,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        // TODO: Use those to customize date indicators
        markedDateWidget: Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 0.3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorfulApp.of(context).colors.bleak,
            // color: AppColors.black1,
          ),
        ),
        // markedDateMoreCustomDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(6.0),
        //   color: Colors.black,
        // ),
        // markedDateShowIcon: true,
        // markedDateIconMaxShown: 0,
        // markedDateMoreShowTotal: true,
      ),
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
