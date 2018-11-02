import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class BottomBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const BottomBox({
    Key key,
    @required this.child,
    this.padding,
    this.borderRadius,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10.0)],
        color: AppColors.white1,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: child,
    );
  }
}
