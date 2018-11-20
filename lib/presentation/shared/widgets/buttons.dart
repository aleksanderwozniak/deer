import 'package:flutter/material.dart';
import 'package:tasking/presentation/colorful_app_builder.dart';
import 'package:tasking/presentation/shared/widgets/box.dart';
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
      color: ColorfulAppBuilder.of(context).data.brightest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: ColorfulAppBuilder.of(context).data.dark),
      ),
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
