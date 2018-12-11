import 'dart:io';

import 'package:deer/presentation/shared/resources.dart';
import 'package:flutter/material.dart';

Widget imageFile(File file) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: Image.file(
        file,
        filterQuality: FilterQuality.low,
        width: 200,
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget imageFilePlaceholder({double size = 128.0, double iconSize = 28.0}) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    width: size,
    height: size,
    child: Stack(
      children: <Widget>[
        Center(child: Container(color: AppColors.black1, height: iconSize, width: 1.0)),
        Center(child: Container(color: AppColors.black1, height: 1.0, width: iconSize)),
      ],
    ),
  );
}
