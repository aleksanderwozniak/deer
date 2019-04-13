import 'package:deer/presentation/app.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/archive_list/archive_list_screen.dart';
import 'package:deer/presentation/screen/calendar/calendar_screen.dart';
import 'package:deer/presentation/screen/privacy.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/screen/todo_list/todo_list_screen.dart';
import 'package:deer/presentation/shared/widgets/box.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/dialogs.dart';
import 'package:deer/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Place variables here
  int _currentIndex;
  Map<String, String> _descriptions;

  @override
  void initState() {
    super.initState();

    final initSettings = InitializationSettings(
      AndroidInitializationSettings('deer_logo'),
      IOSInitializationSettings(),
    );

    notificationManager.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );

    _currentIndex = 0;
    _descriptions = {
      'Calendar': 'Quickly preview and prepare your schedule',
      'All Todos': 'Display all active Todos',
      'Archive': 'Display complete Archive',
      'Settings': 'Customize Deer to your liking',
    };
  }

  // Place methods here
  void _navigate(int index) {
    switch (index) {
      case 0:
        _showCalendar();
        break;
      case 1:
        _showAllTodos();
        break;
      case 2:
        _showArchive();
        break;
      case 3:
        _selectColorTheme();
        break;
      default:
        break;
    }
  }

  void _showCalendar() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CalendarScreen(),
    ));
  }

  void _showAllTodos() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoListScreen(),
    ));
  }

  void _showArchive() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ArchiveListScreen(),
    ));
  }

  void _selectColorTheme() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SimpleDialog(
            title: Text(
              'Select Color Theme',
              style: TextStyle().copyWith(fontSize: 18.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(width: 1.0, color: ColorfulApp.of(context).colors.bleak),
            ),
            children: ColorfulTheme.values
                .skip(1)
                .map((color) => SimpleDialogOption(
                      child: _buildColorDialogOption(
                        text: capitalize(enumToString(color)),
                        mainColor: ColorfulApp.of(context).themeDataFromEnum(color).pale,
                        borderColor: ColorfulApp.of(context).themeDataFromEnum(color).dark,
                      ),
                      onPressed: () => ColorfulApp.of(context).updateColorTheme(color),
                    ))
                .toList(),
          ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RoundedAlertDialog(
            title: 'Privacy Policy',
            content: SingleChildScrollView(
              child: Text(shortPrivacyPolicy, textAlign: TextAlign.center),
            ),
            actions: <Widget>[
              FlatRoundButton(
                text: 'Read more',
                onPressed: _showFullPrivacyPolicy,
              ),
              FlatRoundButton(
                text: 'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  void _showFullPrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PrivacyScreen(),
      fullscreenDialog: true,
    ));
  }

  Future onSelectNotification(String payload) async {
    // Payload should never be null; check just to be sure
    if (payload != null) {
      final todos = await dependencies.todoInteractor.active.first;
      final notificationTodo = todos.firstWhere((e) => e.addedDate.toIso8601String().compareTo(payload) == 0);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoDetailScreen(todo: notificationTodo, editable: true),
        ),
      );
    }
  }

  Widget _buildColorDialogOption({String text, Color mainColor, Color borderColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(text),
          Expanded(child: const SizedBox(width: 8.0)),
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mainColor,
              border: Border.all(color: borderColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorfulApp.of(context).colors.mediumGradient,
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    // Build your root view here
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: const SizedBox(height: 36.0)),
        _buildCarousel(),
        const SizedBox(height: 36.0),
        _buildDescription(),
        Expanded(child: const SizedBox(height: 36.0)),
        _buildFooter(),
      ],
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 320,
      child: Swiper(
        onIndexChanged: (id) => setState(() => _currentIndex = id),
        itemCount: _descriptions.length,
        outer: true,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: SizedBox(
              width: 250,
              child: _buildItem(index),
            ),
          );
        },
        indicatorLayout: PageIndicatorLayout.SCALE,
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(16),
          builder: DotSwiperPaginationBuilder(
            activeColor: ColorfulApp.of(context).colors.bleak,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () => _navigate(index),
            child: Container(),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            _descriptions.keys.elementAt(_currentIndex),
            textAlign: TextAlign.center,
            style: TextStyle().copyWith(fontSize: 22.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            _descriptions.values.elementAt(_currentIndex),
            textAlign: TextAlign.center,
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final footerStyle = TextStyle().copyWith(fontSize: 12.0);
    return GestureDetector(
      onTap: _showPrivacyPolicyDialog,
      child: ShadedBox(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Made by WozAppz 2018-2019', style: footerStyle),
            const SizedBox(height: 3.0),
            Text('Privacy Policy', style: footerStyle),
          ],
        ),
      ),
    );
  }
}
