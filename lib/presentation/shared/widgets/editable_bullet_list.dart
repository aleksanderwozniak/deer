import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class EditableBulletList extends StatefulWidget {
  /// Will contain every BulletList entry.
  ///
  /// Use this to initialize EditableBulletList with values.
  /// If there are no values, pass an empty `List()`.
  final List<String> bulletHolder;
  final bool extraPadding;

  const EditableBulletList({
    Key key,
    @required this.bulletHolder,
    this.extraPadding = true,
  })  : assert(bulletHolder != null),
        super(key: key);

  @override
  _EditableBulletListState createState() => _EditableBulletListState();
}

class _EditableBulletListState extends State<EditableBulletList> {
  List<String> _bullets;
  bool _autofocus;

  @override
  void initState() {
    super.initState();
    _bullets = widget.bulletHolder.toList();
    _autofocus = false;
  }

  void _save() {
    widget.bulletHolder.clear();
    widget.bulletHolder.addAll(_bullets);
  }

  @override
  Widget build(BuildContext context) {
    final children = _bullets.map((bullet) {
      return _buildRow(bullet: bullet);
    }).toList();

    children.add(_buildRow(
      bullet: '',
      autofocus: _autofocus,
    ));

    if (!_autofocus) {
      _autofocus = true;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildRow({@required String bullet, bool autofocus = false}) {
    final controller = TextEditingController(text: bullet);
    controller.addListener(() {
      if (controller.text.trim().isEmpty) {
        setState(() {
          _bullets.remove(bullet);
        });

        _save();
      }
    });

    final children = [
      Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black1,
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: TextField(
          autofocus: autofocus,
          controller: controller,
          maxLines: null,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(hintText: 'New bullet point'),
          onSubmitted: (result) {
            // Empty text should be handled automatically by controller's listener.
            // This is just a double-check.
            if (result.trim().isNotEmpty) {
              int id = _bullets.indexOf(bullet);
              id = id == -1 ? _bullets.length : id;
              setState(() {
                _bullets.remove(bullet);
                _bullets.insert(id, result);
              });

              _save();
            }
          },
        ),
      ),
    ];

    if (widget.extraPadding) {
      children.insert(0, const SizedBox(width: 8.0));
    }

    return Row(children: children);
  }
}
