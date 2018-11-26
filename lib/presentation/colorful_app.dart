import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/utils/string_utils.dart';

typedef Widget AppBuilder(BuildContext context, ThemeData data);

const String _colorfulThemeKey = 'colorfulTheme';

enum ColorfulTheme {
  standard,
  pink,
  blue,
  arcticBlue,
  mix,
  burgundy,
  green,
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
    colors = ColorThemeData.standard();
    _loadColorTheme();
  }

  void nextColorTheme() {
    final currentTheme = colors._currentTheme;
    var id = ColorfulTheme.values.indexOf(currentTheme);

    if (id == ColorfulTheme.values.length - 1) {
      // resets counter, but also avoids `standard`
      id = 1;
    } else {
      id++;
    }

    final newTheme = ColorfulTheme.values.elementAt(id);

    updateColorTheme(newTheme);
  }

  void _setColorTheme(ColorfulTheme theme) {
    setState(() {
      switch (theme) {
        case ColorfulTheme.standard:
          colors = ColorThemeData.standard();
          break;
        case ColorfulTheme.pink:
          colors = ColorThemeData.pink();
          break;
        case ColorfulTheme.blue:
          colors = ColorThemeData.blue();
          break;
        case ColorfulTheme.green:
          colors = ColorThemeData.green();
          break;
        case ColorfulTheme.arcticBlue:
          colors = ColorThemeData.arcticBlue();
          break;
        case ColorfulTheme.mix:
          colors = ColorThemeData.mix();
          break;
        case ColorfulTheme.burgundy:
          colors = ColorThemeData.burgundy();
          break;
      }
    });
  }

  void _loadColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = stringToEnum(prefs.getString(_colorfulThemeKey), ColorfulTheme.values) ?? ColorfulTheme.standard;

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
        hintColor: _dark,
        unselectedWidgetColor: _dark,
        primaryColor: AppColors.white1,
        canvasColor: AppColors.white1,
        textTheme: TextTheme(
          subhead: TextStyle().copyWith(fontSize: 14.0),
        ),
      );

  ColorThemeData.standard()
      : _currentTheme = ColorfulTheme.blue,
        _brightest = AppColors.blue1,
        _bright = AppColors.blue2,
        _medium = AppColors.blue3,
        _dark = AppColors.blue4,
        _darkest = AppColors.blue5,
        _brightGradient = AppColors.blueGradient;

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

  ColorThemeData.green()
      : _currentTheme = ColorfulTheme.green,
        _brightest = AppColors.green1,
        _bright = AppColors.green2,
        _medium = AppColors.green3,
        _dark = AppColors.green4,
        _darkest = AppColors.green5,
        _brightGradient = AppColors.greenGradient;

  ColorThemeData.arcticBlue()
      : _currentTheme = ColorfulTheme.arcticBlue,
        _brightest = AppColors.arcticBlue1,
        _bright = AppColors.arcticBlue2,
        _medium = AppColors.arcticBlue3,
        _dark = AppColors.arcticBlue4,
        _darkest = AppColors.arcticBlue5,
        _brightGradient = AppColors.arcticBlueGradient;

  ColorThemeData.mix()
      : _currentTheme = ColorfulTheme.mix,
        _brightest = AppColors.mix1,
        _bright = AppColors.mix2,
        _medium = AppColors.mix3,
        _dark = AppColors.mix4,
        _darkest = AppColors.mix5,
        _brightGradient = AppColors.mixGradient;

  ColorThemeData.burgundy()
      : _currentTheme = ColorfulTheme.burgundy,
        _brightest = AppColors.burgundy1,
        _bright = AppColors.burgundy2,
        _medium = AppColors.burgundy3,
        _dark = AppColors.burgundy4,
        _darkest = AppColors.burgundy5,
        _brightGradient = AppColors.burgundyGradient;
}
