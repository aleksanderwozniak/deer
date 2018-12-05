import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deer/dependencies.dart';
import 'package:deer/presentation/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final dependencies = Dependencies.standard();

  runApp(App(dependencies: dependencies));
}
