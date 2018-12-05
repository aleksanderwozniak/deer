import 'package:flutter/material.dart';
import 'package:deer/domain/entity/bullet_entity.dart';
import 'package:deer/presentation/colorful_app.dart';

class BulletList extends StatelessWidget {
  final List<BulletEntity> entries;
  final Widget icon;
  final TextStyle entryStyle;
  final bool extraPadding;

  const BulletList({
    Key key,
    this.entries,
    this.icon,
    this.entryStyle,
    this.extraPadding = true,
  })  : assert(entries != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries.map((e) => _buildTile(context, e)).toList(),
    );
  }

  Widget _buildTile(BuildContext context, BulletEntity bullet) {
    final style = bullet.checked
        ? TextStyle().copyWith(
            color: ColorfulApp.of(context).colors.medium,
            decoration: TextDecoration.lineThrough,
          )
        : TextStyle();

    final children = [
      icon ?? _buildDefaultIcon(context),
      const SizedBox(width: 12.0),
      Expanded(
        child: Text(
          bullet.text,
          maxLines: null,
          style: entryStyle ?? style,
        ),
      ),
    ];

    if (extraPadding) {
      children.insert(0, const SizedBox(width: 8.0));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: children),
    );
  }

  Widget _buildDefaultIcon(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorfulApp.of(context).colors.pale,
        border: Border.all(color: ColorfulApp.of(context).colors.bleak),
      ),
    );
  }
}
