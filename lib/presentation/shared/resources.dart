import 'package:flutter/material.dart';

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

  static const Color green1 = const Color(0xffceffce);
  static const Color green2 = const Color(0xffabe8a9);
  static const Color green3 = const Color(0xff68cc68);
  static const Color green4 = const Color(0xff677f67);
  static const Color green5 = const Color(0xff417f41);

  // [WIP]
  static const Color arcticBlue1 = const Color(0xffcedcff);
  static const Color arcticBlue2 = const Color(0xffa9b9e8);
  static const Color arcticBlue3 = const Color(0xff6881cc);
  static const Color arcticBlue4 = const Color(0xff676d7f);
  static const Color arcticBlue5 = const Color(0xff41507f);

  static const Color mix1 = const Color(0xff906765);
  static const Color mix2 = const Color(0xff595c7c);
  static const Color mix3 = const Color(0xff3a435e);
  static const Color mix4 = const Color(0xff946b69);
  static const Color mix5 = const Color(0xff50668c);

  static const Color burgundy1 = const Color(0xffC93426);
  static const Color burgundy2 = const Color(0xffA12B20);
  static const Color burgundy3 = const Color(0xff751F17);
  static const Color burgundy4 = const Color(0xff522C28);
  static const Color burgundy5 = const Color(0xff4C110B);

  // static const Color arcticBlue1 = const Color(0xffc6ecff);
  // static const Color arcticBlue2 = const Color(0xffa0cde8);
  // static const Color arcticBlue3 = const Color(0xff5799cc);
  // static const Color arcticBlue4 = const Color(0xff566f7f);
  // static const Color arcticBlue5 = const Color(0xff2a577f);

  static const Color white1 = Colors.white;
  static const Color black1 = Colors.black;

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.pink1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.blue1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.green1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient arcticBlueGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.arcticBlue1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient mixGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.mix1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient burgundyGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.burgundy1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );
}
