import 'package:flutter/material.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/shared/resources.dart';

class TagActionChip extends StatefulWidget {
  final String title;
  final bool initiallySelected;
  final VoidCallback onTap;

  const TagActionChip({
    Key key,
    @required this.title,
    @required this.onTap,
    this.initiallySelected = false,
  })  : assert(title != null),
        assert(onTap != null),
        super(key: key);

  @override
  _TagActionChipState createState() => _TagActionChipState();
}

class _TagActionChipState extends State<TagActionChip> {
  bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initiallySelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });

        widget.onTap();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: ColorfulApp.of(context).colors.bleak, width: 0.0),
          color: _isSelected ? ColorfulApp.of(context).colors.pale : AppColors.white1,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(widget.title),
      ),
    );
  }
}
