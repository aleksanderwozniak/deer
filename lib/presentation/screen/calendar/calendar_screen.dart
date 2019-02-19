import 'package:deer/presentation/colorful_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Place variables here

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Place methods here
  void submit() {}

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorfulApp.of(context).colors.dark),
        title: Text('Calendar View'),
        centerTitle: true,
      ),
      body: SafeArea(top: true, bottom: true, child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildCalendarCarousel(),
    );
  }

  Widget _buildCalendarCarousel() {
    return CalendarCarousel(
      markedDatesMap: EventList(
        events: {
          DateTime(2019, 2, 24): ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
          DateTime(2019, 2, 26): ['1', '2'],
        },
      ),
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
