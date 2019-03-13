import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:flutter/material.dart';

class TodoAvatar extends StatelessWidget {
  final String text;
  final bool isLarge;
  final bool isFinished;
  final bool showNotification;

  const TodoAvatar({
    Key key,
    @required this.text,
    this.isLarge = false,
    this.isFinished = false,
    this.showNotification = false,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showNotification) {
      return _buildStack(context);
    } else {
      return _buildCircle(context);
    }
  }

  Widget _buildStack(BuildContext context) {
    final size = isLarge ? 24.0 : 16.0;

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        _buildCircle(context),
        Positioned(
          right: -1.0,
          top: -1.0,
          child: Icon(
            Icons.notifications,
            size: size,
            color: ColorfulApp.of(context).colors.bleak,
          ),
        ),
      ],
    );
  }

  Widget _buildCircle(BuildContext context) {
    final diameter = isLarge ? 64.0 : 40.0;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: ColorfulApp.of(context).colors.bleak,
        ),
        color: isLarge ? ColorfulApp.of(context).colors.pale : AppColors.white1,
      ),
      child: Center(child: _buildContentInCircle(context)),
    );
  }

  Widget _buildContentInCircle(BuildContext context) {
    final size = isLarge ? 28.0 : 16.0;

    if (isFinished) {
      return Icon(
        Icons.done,
        size: size * 1.3,
        color: ColorfulApp.of(context).colors.bleak,
      );
    } else {
      return Text(
        text[0].toUpperCase(),
        style: TextStyle().copyWith(fontSize: size),
      );
    }
  }
}
