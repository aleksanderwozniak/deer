import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/themes.dart';

typedef Widget AppBuilder(BuildContext context, ThemeData data);

enum ColorfulTheme {
  pink,
  blue,
}

class ColorfulAppBuilder extends StatefulWidget {
  final AppBuilder builder;
  final ColorThemeData colorTheme;

  ColorfulAppBuilder({
    Key key,
    this.builder,
    this.colorTheme,
  }) : super(key: key);

  static ColorfulAppBuilderState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ColorfulAppBuilderState>());
  }

  @override
  ColorfulAppBuilderState createState() => ColorfulAppBuilderState();
}

class ColorfulAppBuilderState extends State<ColorfulAppBuilder> {
  ColorThemeData data;

  @override
  void initState() {
    super.initState();
    data = widget.colorTheme;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, data.theme);
  }

  void setColor(ColorfulTheme color) {
    switch (color) {
      case ColorfulTheme.pink:
        setState(() {
          data = ColorThemeData.pink();
        });
        break;
      case ColorfulTheme.blue:
        setState(() {
          data = ColorThemeData.blue();
        });
        break;
    }
  }
}

class ColorThemeData {
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

  // TODO
  ThemeData get theme => Themes.standard.copyWith(
        accentColor: _medium ?? AppColors.pink3,
        cursorColor: _dark ?? AppColors.pink4,
        textSelectionColor: _bright ?? AppColors.pink2,
        textSelectionHandleColor: _medium ?? AppColors.pink3,
      );

  ColorThemeData.pink()
      : _brightest = AppColors.pink1,
        _bright = AppColors.pink2,
        _medium = AppColors.pink3,
        _dark = AppColors.pink4,
        _darkest = AppColors.pink5,
        _brightGradient = AppColors.pinkGradient;

  ColorThemeData.blue()
      : _brightest = AppColors.blue1,
        _bright = AppColors.blue2,
        _medium = AppColors.blue3,
        _dark = AppColors.blue4,
        _darkest = AppColors.blue5,
        _brightGradient = AppColors.blueGradient;
}
