import 'package:flutter/material.dart';

// Unused (?)
class RoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;

  const RoundAppBar({
    Key key,
    this.title = '',
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Container(
        child: _buildContent(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
            color: color,
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10.0)]),
        // boxShadow: [BoxShadow(color: AppColors.black1, blurRadius: 4.0)]),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
