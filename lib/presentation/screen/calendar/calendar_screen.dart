import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/calendar/calendar_actions.dart';
import 'package:deer/presentation/screen/calendar/calendar_bloc.dart';
import 'package:deer/presentation/screen/calendar/calendar_state.dart';
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
  void _onDayPressed<T>(DateTime date, List<T> events) {
    _bloc.actions.add(UpdateField(field: Field.selectedDate, value: date));

    // debug print
    events.forEach((e) => print(e.toString()));
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildCalendarCarousel(state),
    );
  }

  Widget _buildCalendarCarousel(CalendarState state) {
    return CalendarCarousel(
      markedDatesMap: EventList(
        events: {
          DateTime(2019, 2, 24): ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
          DateTime(2019, 2, 26): ['1', '2'],
        },
      ),
      onDayPressed: _onDayPressed,
      selectedDateTime: state.selectedDate,
      // TODO: Use those to customize date indicators
      // markedDateMoreCustomDecoration: BoxDecoration(
      //   color: Colors.blue,
      //   shape: BoxShape.circle,
      // ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 0,
      // markedDateMoreShowTotal: true,
    );
  }
}
