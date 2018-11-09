import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tuple/tuple.dart';

class EditableBulletList extends StatefulWidget {
  /// Will contain every BulletList entry.
  ///
  /// Use this to initialize EditableBulletList with values.
  /// If there are no values, pass an empty `List()`.
  final List<String> initialBulletPoints;
  final bool extraPadding;
  final ValueChanged<List<String>> onChanged;

  const EditableBulletList({
    Key key,
    @required this.onChanged,
    this.initialBulletPoints = const [],
    this.extraPadding = true,
  })  : assert(onChanged != null),
        super(key: key);

  @override
  _EditableBulletListState createState() => _EditableBulletListState();
}

class _EditableBulletListState extends State<EditableBulletList> {
  // BuiltList<String> _bullets;
  BuiltList<Tuple2<String, FocusNode>> _bullets;
  bool _autofocus;

  @override
  void initState() {
    super.initState();

    // _bullets = BuiltList(widget.initialBulletPoints.toList());
    _bullets = BuiltList<Tuple2<String, FocusNode>>(widget.initialBulletPoints.map((text) => Tuple2(text, FocusNode())));
    _autofocus = false;
  }

  @override
  Widget build(BuildContext context) {
    var children = [];

    final end = _bullets.length - 1;
    children = _bullets.sublist(0, end > 0 ? end : 0).map((bullet) => _buildRow(bullet: bullet)).toList();

    try {
      children.add(_buildRow(bullet: _bullets.last, autofocus: _autofocus));
    } catch (e) {
      if (children.isEmpty) {
        _bullets = _bullets.rebuild((b) => b..add(Tuple2(' ', FocusNode())));
        children.add(_buildRow(bullet: _bullets.last, autofocus: _autofocus));
      }
    }

    // if (!_autofocus) {
    // _autofocus = true;
    // }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildRow({@required Tuple2<String, FocusNode> bullet, bool autofocus = false}) {
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
        child: _TextField(
          // autofocus: autofocus,
          focusNode: bullet.item2,
          maxLines: null,
          inputAction: TextInputAction.next,
          hint: 'Next bullet point',
          value: bullet.item1,
          onChanged: (value) {
            final id = _bullets.indexOf(bullet);
            if (value.isEmpty) {
              if (id >= 0) {
                setState(() {
                  _bullets = _bullets.rebuild((b) => b..remove(bullet));
                });
              }
              // Future.delayed(Duration(milliseconds: 250), () {
              // FocusScope.of(context).requestFocus(_bullets[id - 1].item2);
              // });
              if (id - 1 >= 0) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).requestFocus(_bullets[id - 1].item2);
                });
              }
            } else {
              setState(() {
                final b = _bullets.toBuilder();
                b[id] = Tuple2(value, bullet.item2);
                _bullets = b.build();
              });
            }

            widget.onChanged(_bullets.map((bullet) => bullet.item1).toList());
          },
          onSubmitted: (result) {
            final id = _bullets.indexOf(bullet);
            setState(() {
              // _bullets = _bullets.rebuild((b) => b..add(Tuple2(' ', FocusNode())));
              // FocusScope.of(context).requestFocus(_bullets[id - 1].item2);
              // MARK: disable autofocus for this v
              _bullets = _bullets.rebuild((b) => b..insert(id + 1, Tuple2(' ', FocusNode())));
            });
            // Future.delayed(Duration(milliseconds: 250), () {
            //   FocusScope.of(context).requestFocus(_bullets[id + 1].item2);
            // });
            SchedulerBinding.instance.addPostFrameCallback((_) {
              FocusScope.of(context).requestFocus(_bullets[id + 1].item2);
            });
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

class _TextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final String value;
  final String hint;
  final double fontSize;
  final int maxLines;
  final int maxLength;
  final bool maxLengthEnforced;
  final bool autofocus;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const _TextField({
    Key key,
    this.focusNode,
    this.inputAction,
    this.value,
    this.hint,
    this.fontSize = 14.0,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  TextEditingValue _value;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController.fromValue(
      _value?.copyWith(text: widget.value) ?? TextEditingValue(text: widget.value),
    );

    controller.addListener(() {
      _value = controller.value;
      widget.onChanged(controller.text);
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
      child: TextField(
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLengthEnforced,
        style: TextStyle().copyWith(
          color: AppColors.black1,
          fontSize: widget.fontSize,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle().copyWith(
            color: AppColors.grey3,
            fontSize: widget.fontSize,
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
