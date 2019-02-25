import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:flutter/material.dart';

Widget buildDismissibleBackground({
  @required BuildContext context,
  @required bool leftToRight,
}) {
  assert(context != null);
  assert(leftToRight != null);

  final alignment = leftToRight ? Alignment.centerLeft : Alignment.centerRight;
  final colors =
      leftToRight ? [ColorfulApp.of(context).colors.bright, AppColors.white1] : [AppColors.white1, ColorfulApp.of(context).colors.bright];

  return Container(
    child: Text(
      'Done',
      style: TextStyle().copyWith(color: AppColors.white1, fontSize: 20.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    alignment: alignment,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: colors),
    ),
  );
}
