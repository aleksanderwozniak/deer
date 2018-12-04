import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/utils/string_utils.dart';

typedef Widget AppBuilder(BuildContext context, ThemeData data);

const String _colorfulThemeKey = 'colorfulTheme';

enum ColorfulTheme {
  standard,
  salmon,
  indigo,
  mint,
  arcticBlue,
  golden,
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

  ColorThemeData themeDataFromEnum(ColorfulTheme theme) {
    switch (theme) {
      case ColorfulTheme.standard:
        return ColorThemeData.standard();
      case ColorfulTheme.salmon:
        return ColorThemeData.salmon();
      case ColorfulTheme.indigo:
        return ColorThemeData.indigo();
      case ColorfulTheme.mint:
        return ColorThemeData.mint();
      case ColorfulTheme.arcticBlue:
        return ColorThemeData.arcticBlue();
      case ColorfulTheme.golden:
        return ColorThemeData.golden();
      default:
        return ColorThemeData.standard();
    }
  }

  void updateColorTheme(ColorfulTheme theme) async {
    _setColorTheme(theme);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_colorfulThemeKey, enumToString(theme));
  }

  void _setColorTheme(ColorfulTheme theme) {
    setState(() {
      colors = themeDataFromEnum(theme);
    });
  }

  void _loadColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = stringToEnum(prefs.getString(_colorfulThemeKey), ColorfulTheme.values) ?? ColorfulTheme.standard;

    _setColorTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, colors.theme);
  }
}

class ColorThemeData {
  ColorfulTheme get currentTheme => _currentTheme;
  ColorfulTheme _currentTheme;

  // Main color - gradients, buttons, tags
  Color get pale => _pale;
  Color _pale;

  // DismissibleBackground color
  Color get bright => _bright;
  Color _bright;

  // Accent color, hint color
  Color get medium => _medium;
  Color _medium;

  // Icon color, error color
  Color get dark => _dark;
  Color _dark;

  // Label color, border color
  Color get bleak => _bleak;
  Color _bleak;

  LinearGradient get brightGradient => _brightGradient;
  LinearGradient _brightGradient;

  ThemeData get theme => ThemeData(
        accentColor: _medium,
        cursorColor: _bleak,
        textSelectionColor: _bright,
        textSelectionHandleColor: _medium,
        hintColor: _bleak,
        unselectedWidgetColor: _bleak,
        primaryColor: AppColors.white1,
        canvasColor: AppColors.white1,
        textTheme: TextTheme(
          subhead: TextStyle().copyWith(fontSize: 14.0),
        ),
      );

  ColorThemeData.standard()
      : _currentTheme = ColorfulTheme.indigo,
        _pale = AppColors.indigo1,
        _bright = AppColors.indigo2,
        _medium = AppColors.indigo3,
        _bleak = AppColors.indigo4,
        _dark = AppColors.indigo5,
        _brightGradient = AppColors.indigoGradient;

  ColorThemeData.salmon()
      : _currentTheme = ColorfulTheme.salmon,
        _pale = AppColors.salmon1,
        _bright = AppColors.salmon2,
        _medium = AppColors.salmon3,
        _bleak = AppColors.salmon4,
        _dark = AppColors.salmon5,
        _brightGradient = AppColors.salmonGradient;

  ColorThemeData.indigo()
      : _currentTheme = ColorfulTheme.indigo,
        _pale = AppColors.indigo1,
        _bright = AppColors.indigo2,
        _medium = AppColors.indigo3,
        _bleak = AppColors.indigo4,
        _dark = AppColors.indigo5,
        _brightGradient = AppColors.indigoGradient;

  ColorThemeData.mint()
      : _currentTheme = ColorfulTheme.mint,
        _pale = AppColors.mint1,
        _bright = AppColors.mint2,
        _medium = AppColors.mint3,
        _bleak = AppColors.mint4,
        _dark = AppColors.mint5,
        _brightGradient = AppColors.mintGradient;

  ColorThemeData.arcticBlue()
      : _currentTheme = ColorfulTheme.arcticBlue,
        _pale = AppColors.arcticBlue1,
        _bright = AppColors.arcticBlue2,
        _medium = AppColors.arcticBlue3,
        _bleak = AppColors.arcticBlue4,
        _dark = AppColors.arcticBlue5,
        _brightGradient = AppColors.arcticBlueGradient;

  ColorThemeData.golden()
      : _currentTheme = ColorfulTheme.golden,
        _pale = AppColors.golden1,
        _bright = AppColors.golden2,
        _medium = AppColors.golden3,
        _bleak = AppColors.golden4,
        _dark = AppColors.golden5,
        _brightGradient = AppColors.goldenGradient;
}
