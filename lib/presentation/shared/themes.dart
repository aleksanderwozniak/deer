import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class Themes {
  const Themes._();

  static final ThemeData main = ThemeData(
    primaryColor: AppColors.white1,
    accentColor: AppColors.grey3,
    canvasColor: AppColors.white1,
    cursorColor: AppColors.grey4,
    textSelectionColor: AppColors.grey2,
    textSelectionHandleColor: AppColors.grey3,
    textTheme: TextTheme(
      subhead: TextStyle().copyWith(fontSize: 14.0),
    ),
  );
}
