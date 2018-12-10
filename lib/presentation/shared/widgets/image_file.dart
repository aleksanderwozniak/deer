import 'dart:io';

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

Widget imageFilePlaceholder() {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    width: 200,
    height: 200,
  );
}
