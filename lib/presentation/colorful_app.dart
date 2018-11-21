import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/utils/string_utils.dart';

typedef Widget AppBuilder(BuildContext context, ThemeData data);

const String _colorfulThemeKey = 'colorfulTheme';

enum ColorfulTheme {
  pink,
  blue,
}

class ColorfulApp extends StatefulWidget {
  final AppBuilder builder;

  ColorfulApp({
    Key key,
    this.builder,
  }) : super(key: key);

  static ColorfulAppState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ColorfulAppState>());
  }

  @override
  ColorfulAppState createState() => ColorfulAppState();
}

class ColorfulAppState extends State<ColorfulApp> {
  ColorThemeData colors;

  @override
  void initState() {
    super.initState();

    // Hack, needed since _loadColorTheme is async
    colors = ColorThemeData.pink();
    _loadColorTheme();
  }

  void _setColorTheme(ColorfulTheme theme) {
    switch (theme) {
      case ColorfulTheme.pink:
        setState(() {
          colors = ColorThemeData.pink();
        });
        break;
      case ColorfulTheme.blue:
        setState(() {
          colors = ColorThemeData.blue();
        });
        break;
    }
  }

  void _loadColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = stringToEnum(prefs.getString(_colorfulThemeKey), ColorfulTheme.values) ?? ColorfulTheme.pink;

    _setColorTheme(theme);
  }

  void updateColorTheme(ColorfulTheme theme) async {
    _setColorTheme(theme);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_colorfulThemeKey, enumToString(theme));
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, colors.theme);
  }
}

class ColorThemeData {
  ColorfulTheme get currentTheme => _currentTheme;
  ColorfulTheme _currentTheme;

  Color get brightest => _brightest;
  Color _brightest;

  Color get bright => _bright;
  Color _bright;

  Color get medium => _medium;
  Color _medium;

  Color get dark => _dark;
  Color _dark;

  Color get darkest => _darkest;
  Color _darkest;

  LinearGradient get brightGradient => _brightGradient;
  LinearGradient _brightGradient;

  ThemeData get theme => ThemeData(
        accentColor: _medium,
        cursorColor: _dark,
        textSelectionColor: _bright,
        textSelectionHandleColor: _medium,
        primaryColor: AppColors.white1,
        canvasColor: AppColors.white1,
        textTheme: TextTheme(
          subhead: TextStyle().copyWith(fontSize: 14.0),
        ),
      );

  ColorThemeData.pink()
      : _currentTheme = ColorfulTheme.pink,
        _brightest = AppColors.pink1,
        _bright = AppColors.pink2,
        _medium = AppColors.pink3,
        _dark = AppColors.pink4,
        _darkest = AppColors.pink5,
        _brightGradient = AppColors.pinkGradient;

  ColorThemeData.blue()
      : _currentTheme = ColorfulTheme.blue,
        _brightest = AppColors.blue1,
        _bright = AppColors.blue2,
        _medium = AppColors.blue3,
        _dark = AppColors.blue4,
        _darkest = AppColors.blue5,
        _brightGradient = AppColors.blueGradient;
}
