import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/themes.dart';

class AppColors {
  const AppColors._();

  static const Color pink1 = const Color(0xffffcece);
  static const Color pink2 = const Color(0xffe8a9ab);
  // static const Color pink2 = const Color(0xffff8282);
  static const Color pink3 = const Color(0xffcc6868);
  static const Color pink4 = const Color(0xff7f6767);
  static const Color pink5 = const Color(0xff7f4141);

  static const Color blue1 = const Color(0xffceceff);
  static const Color blue2 = const Color(0xffaba9e8);
  static const Color blue3 = const Color(0xff6868cc);
  static const Color blue4 = const Color(0xff67677f);
  static const Color blue5 = const Color(0xff41417f);

  static const Color white1 = Colors.white;
  static const Color black1 = Colors.black;

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.pink1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  // [WIP]
  static const LinearGradient blueGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.blue1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );
}

class ColorTheme extends InheritedWidget {
  final ColorThemeData data;

  ColorTheme({
    Widget child,
    this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ColorTheme oldWidget) {
    // return data != oldWidget.data;
    return true;
  }

  static ColorThemeData of(BuildContext context) {
    final ColorTheme inheritedCollorTheme = context.inheritFromWidgetOfExactType(ColorTheme);
    ColorThemeData colorData = inheritedCollorTheme?.data;
    return colorData;
  }
}

typedef Widget AppBuilder(BuildContext context, ThemeData data);

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

enum ColorfulTheme { pink, blue }

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
