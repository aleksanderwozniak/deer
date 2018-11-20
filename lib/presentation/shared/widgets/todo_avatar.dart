import 'package:flutter/material.dart';
import 'package:tasking/presentation/colorful_app_builder.dart';
import 'package:tasking/presentation/shared/resources.dart';

class TodoAvatar extends StatelessWidget {
  final String text;
  final bool isLarge;

  const TodoAvatar({
    Key key,
    @required this.text,
    this.isLarge = false,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final diameter = isLarge ? 64.0 : 40.0;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: ColorfulAppBuilder.of(context).data.dark,
        ),
        color: isLarge ? ColorfulAppBuilder.of(context).data.brightest : AppColors.white1,
      ),
      child: Center(child: _buildContentInCircle()),
    );
  }

  Widget _buildContentInCircle() {
    final fontSize = isLarge ? 28.0 : 16.0;

    return Text(
      text[0].toUpperCase(),
      style: TextStyle().copyWith(fontSize: fontSize),
    );
  }
}
