import 'package:deer/dependencies.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/todo_list/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Dependencies _sharedDependencies;
Dependencies get dependencies => _sharedDependencies;

FlutterLocalNotificationsPlugin _notificationManager;
FlutterLocalNotificationsPlugin get notificationManager => _notificationManager;

class App extends StatelessWidget {
  App({
    Key key,
    Dependencies dependencies,
    FlutterLocalNotificationsPlugin notificationManager,
  }) : super(key: key) {
    _sharedDependencies = dependencies;
    _notificationManager = notificationManager;
  }

  final String _title = 'Todos';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ColorfulApp(
      builder: (context, theme) {
        return MaterialApp(
          title: _title,
          theme: theme,
          home: TodoListScreen(title: _title),
        );
      },
    );
  }
}
