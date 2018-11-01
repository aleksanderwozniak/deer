import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text),
      onPressed: onPressed,
      color: AppColors.grey2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: AppColors.grey4),
      ),
    );
  }
}
