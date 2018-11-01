import 'package:flutter/material.dart';

class TodoAvatar extends StatelessWidget {
  final String text;

  const TodoAvatar({
    Key key,
    this.text,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final diameter = 40.0;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: Colors.grey[700],
        ),
      ),
      child: Center(child: _buildContentInCircle()),
    );
  }

  Widget _buildContentInCircle() {
    return Text(text[0].toUpperCase());
  }
}
