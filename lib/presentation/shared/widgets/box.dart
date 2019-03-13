import 'package:deer/presentation/shared/resources.dart';
import 'package:flutter/material.dart';

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

class ShadedBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const ShadedBox({
    Key key,
    @required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2.0)],
        // boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4.0)],
        color: AppColors.white1,
      ),
      padding: padding,
      child: child,
    );
  }
}
