import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/shared/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
      color: ColorfulApp.of(context).colors.pale,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: ColorfulApp.of(context).colors.bleak),
      ),
    );
  }
}

class FlatRoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double radius;
  final TextStyle style;

  FlatRoundButton({
    Key key,
    @required this.text,
    @required this.onTap,
    this.radius = 8.0,
    this.style,
  })  : assert(text != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: ColorfulApp.of(context).colors.pale.withOpacity(0.4),
      splashColor: ColorfulApp.of(context).colors.medium.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Text(
          text,
          style: style ??
              TextStyle().copyWith(
                color: ColorfulApp.of(context).colors.medium,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BottomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBox(
      child: Center(
        child: RoundButton(text: text, onPressed: onPressed),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
    );
  }
}

/// Use when multiple BottomButtons are needed.
/// NOTE: Beware of overflowing horizontal space!
class BottomButtonRow extends StatelessWidget {
  final List<Tuple2<String, VoidCallback>> buttonsData;

  /// Use when multiple BottomButtons are needed.
  /// NOTE: Beware of overflowing horizontal space!
  const BottomButtonRow({
    Key key,
    @required this.buttonsData,
  })  : assert(buttonsData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBox(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttonsData
              .map((tuple) => RoundButton(
                    text: tuple.item1,
                    onPressed: tuple.item2,
                  ))
              .toList(),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
    );
  }
}
