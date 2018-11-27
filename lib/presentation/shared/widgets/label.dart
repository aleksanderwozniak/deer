import 'package:flutter/material.dart';
import 'package:tasking/presentation/colorful_app.dart';

Widget buildCentralLabel({String text, BuildContext context}) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorfulApp.of(context).colors.bleak),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        text,
        style: TextStyle().copyWith(color: ColorfulApp.of(context).colors.bleak),
      ),
    ),
  );
}
