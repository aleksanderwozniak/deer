import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/bullet_entity.dart';
import 'package:tasking/presentation/shared/resources.dart';

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
      children: entries.map((e) => _buildTile(e)).toList(),
    );
  }

  Widget _buildTile(BulletEntity bullet) {
    final style = bullet.checked
        ? TextStyle().copyWith(
            color: AppColors.pink3,
            decoration: TextDecoration.lineThrough,
          )
        : TextStyle();

    final children = [
      icon ?? _buildDefaultIcon(),
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

  Widget _buildDefaultIcon() {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black1,
      ),
    );
  }
}
