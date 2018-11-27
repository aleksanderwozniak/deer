import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color salmon1 = const Color(0xffFFCAC2);
  static const Color salmon2 = const Color(0xffFFAFA3);
  static const Color salmon3 = const Color(0xffFF998A);
  static const Color salmon4 = const Color(0xff66433D);
  static const Color salmon5 = const Color(0xff7F2D20);

  static const Color indigo1 = const Color(0xffCCCFFF);
  static const Color indigo2 = const Color(0xffB2B8FF);
  static const Color indigo3 = const Color(0xff99A0FF);
  static const Color indigo4 = const Color(0xff3D4066);
  static const Color indigo5 = const Color(0xff20267F);

  static const Color mint1 = const Color(0xffADFFDC);
  static const Color mint2 = const Color(0xff6ee5b2);
  static const Color mint3 = const Color(0xff2EE596);
  static const Color mint4 = const Color(0xff3D6654);
  static const Color mint5 = const Color(0xff207F56);

  static const Color arcticBlue1 = const Color(0xffB2E8FF);
  static const Color arcticBlue2 = const Color(0xff87D4F5);
  static const Color arcticBlue3 = const Color(0xff52BDEB);
  static const Color arcticBlue4 = const Color(0xff3D5A66);
  static const Color arcticBlue5 = const Color(0xff20637F);

  static const Color golden1 = const Color(0xffFFD7A3);
  static const Color golden2 = const Color(0xffFFCA85);
  static const Color golden3 = const Color(0xffFFBD66);
  static const Color golden4 = const Color(0xff66543D);
  static const Color golden5 = const Color(0xff7F5620);

  static const Color white1 = Colors.white;
  static const Color black1 = Colors.black;

  static const LinearGradient salmonGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.salmon1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient indigoGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.indigo1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient mintGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.mint1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient arcticBlueGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.arcticBlue1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  static const LinearGradient goldenGradient = LinearGradient(
    colors: [AppColors.white1, AppColors.golden1],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );
}
