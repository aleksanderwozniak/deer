import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasking/dependencies.dart';
import 'package:tasking/presentation/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final dependencies = Dependencies.standard();

  runApp(App(dependencies: dependencies));
}
