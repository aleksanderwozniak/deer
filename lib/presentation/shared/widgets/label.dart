import 'package:flutter/material.dart';
import 'package:deer/presentation/colorful_app.dart';

Widget buildCentralLabel({String text, BuildContext context}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Opacity(
          opacity: 0.66,
          child: Image.asset(
            'assets/images/deer_logo.png',
            // https://github.com/flutter/flutter/issues/12990
            // color: ColorfulApp.of(context).colors.pale,
            // colorBlendMode: BlendMode.lighten,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
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
        const SizedBox(height: 32.0),
      ],
    ),
  );
}
