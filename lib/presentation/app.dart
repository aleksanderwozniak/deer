import 'package:flutter/material.dart';
import 'package:tasking/dependencies.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_screen.dart';
import 'package:tasking/presentation/shared/resources.dart';

Dependencies _sharedDependencies;
Dependencies get dependencies => _sharedDependencies;

class App extends StatelessWidget {
  App({
    Key key,
    Dependencies dependencies,
  }) : super(key: key) {
    _sharedDependencies = dependencies;
  }

  final String _title = 'Tasking';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //   final data = ColorThemeData.pink();

    //   return ColorTheme(
    //     // data: ColorThemeData.pink(),
    //     data: data,
    //     child: MaterialApp(
    //       title: _title,
    //       // theme: Themes.main,
    //       // theme: Themes.standard.copyWith(
    //       //   accentColor: ColorTheme.of(context)?.medium ?? AppColors.pink3,
    //       //   cursorColor: ColorTheme.of(context)?.dark ?? AppColors.pink4,
    //       //   textSelectionColor: ColorTheme.of(context)?.bright ?? AppColors.pink2,
    //       //   textSelectionHandleColor: ColorTheme.of(context)?.medium ?? AppColors.pink3,
    //       // ),
    //       theme: data.theme,
    //       home: TodoListScreen(title: _title),
    //     ),
    //   );
    // }

    return ColorfulAppBuilder(
      colorTheme: ColorThemeData.pink(),
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
