import 'package:flutter/material.dart';
import 'package:tasking/dependencies.dart';
import 'package:tasking/presentation/screen/task_list/task_list_screen.dart';

Dependencies _sharedDependencies;
Dependencies get dependencies => _sharedDependencies;

class App extends StatelessWidget {
  App({
    Key key,
    Dependencies dependencies,
  }) : super(key: key) {
    _sharedDependencies = dependencies;
  }

  final String _title = 'TasKing';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskListScreen(title: _title),
    );
  }
}
