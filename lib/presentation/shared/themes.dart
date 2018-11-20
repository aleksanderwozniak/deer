import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class Themes {
  const Themes._();

  static final ThemeData main = ThemeData(
    primaryColor: AppColors.white1,
    accentColor: AppColors.pink3,
    canvasColor: AppColors.white1,
    cursorColor: AppColors.pink4,
    textSelectionColor: AppColors.pink2,
    textSelectionHandleColor: AppColors.pink3,
    textTheme: TextTheme(
      subhead: TextStyle().copyWith(fontSize: 14.0),
    ),
  );

  static final ThemeData standard = ThemeData(
    primaryColor: AppColors.white1,
    canvasColor: AppColors.white1,
    textTheme: TextTheme(
      subhead: TextStyle().copyWith(fontSize: 14.0),
    ),
  );
}
