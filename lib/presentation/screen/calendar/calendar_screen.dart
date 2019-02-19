import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Place variables here
  CalendarBloc _bloc;
  EventList _mockEvents;

  @override
  void initState() {
    super.initState();
    _bloc = CalendarBloc();

    _mockEvents = EventList(
      events: {
        DateTime(2019, 2, 24): ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
        DateTime(2019, 2, 26): ['1', '2'],
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _onDayPressed<T>(DateTime date, List<T> events) {
    _bloc.actions.add(UpdateField(field: Field.selectedDate, value: date));

    final todos = events.map((e) => TodoEntity(name: e.toString())).toList();
    _bloc.actions.add(UpdateField(field: Field.scheduledTodos, value: todos));

    // debug print
    events.forEach((e) => print(e.toString()));
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
    if (state.scheduledTodos.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: _buildCalendarCarousel(state),
            flex: 2,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: _buildScheduledTodos(state),
            fit: FlexFit.loose,
          ),
        ],
      );
    } else {
      return _buildCalendarCarousel(state);
    }
  }

  Widget _buildCalendarCarousel(CalendarState state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        markedDatesMap: _mockEvents,
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
