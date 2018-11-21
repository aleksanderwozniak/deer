import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color pink1 = const Color(0xffffcece);
  static const Color pink2 = const Color(0xffe8a9ab);
  // static const Color pink2 = const Color(0xffff8282);
  static const Color pink3 = const Color(0xffcc6868);
  static const Color pink4 = const Color(0xff7f6767);
  static const Color pink5 = const Color(0xff7f4141);

  // [WIP]
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
