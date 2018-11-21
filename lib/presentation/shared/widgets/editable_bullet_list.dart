import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasking/domain/entity/bullet_entity.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tuple/tuple.dart';

class EditableBulletList extends StatefulWidget {
  final bool extraPadding;
  final List<BulletEntity> initialBulletPoints;
  final ValueChanged<List<BulletEntity>> onChanged;

  const EditableBulletList({
    Key key,
    this.extraPadding = true,
    this.initialBulletPoints = const [],
    @required this.onChanged,
  })  : assert(onChanged != null),
        super(key: key);

  @override
  _EditableBulletListState createState() => _EditableBulletListState();
}

class _EditableBulletListState extends State<EditableBulletList> {
  BuiltList<Tuple2<BulletEntity, FocusNode>> _bullets;

  @override
  void initState() {
    super.initState();

    _bullets = BuiltList<Tuple2<BulletEntity, FocusNode>>(widget.initialBulletPoints.map(
      (text) => Tuple2(text, FocusNode()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var children = [];

    final end = _bullets.length - 1;
    children = _bullets.sublist(0, end > 0 ? end : 0).map((bullet) => _buildRow(bullet: bullet)).toList();

    try {
      children.add(_buildRow(bullet: _bullets.last));
    } catch (e) {
      if (children.isEmpty) {
        _bullets = _bullets.rebuild((b) => b..add(Tuple2(BulletEntity(text: ' ', checked: false), FocusNode())));
        children.add(_buildRow(bullet: _bullets.last));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildRow({@required Tuple2<BulletEntity, FocusNode> bullet}) {
    final children = [
      Checkbox(
        value: bullet.item1.checked,
        onChanged: (value) {
          final id = _bullets.indexOf(bullet);
          setState(() {
            final b = _bullets.toBuilder();
            b[id] = Tuple2(BulletEntity(text: bullet.item1.text, checked: value), bullet.item2);
            _bullets = b.build();
          });

          widget.onChanged(_bullets.map((bullet) {
            final text = bullet.item1.text.trimLeft();
            final checked = bullet.item1.checked;
            return BulletEntity(text: text, checked: checked);
          }).toList());
        },
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: _TextField(
          focusNode: bullet.item2,
          maxLines: null,
          inputAction: TextInputAction.next,
          hint: 'Next bullet point',
          value: ' ${bullet.item1.text.trimLeft()}',
          checked: bullet.item1.checked,
          onChanged: (value) {
            final id = _bullets.indexOf(bullet);
            if (value.isEmpty) {
              if (id >= 0) {
                setState(() {
                  _bullets = _bullets.rebuild((b) => b..remove(bullet));
                });

                final node = id > 0 ? _bullets[id - 1].item2 : FocusNode();

                SchedulerBinding.instance.scheduleFrameCallback((_) {
                  FocusScope.of(context).requestFocus(node);
                });
              }
            } else {
              setState(() {
                final b = _bullets.toBuilder();
                b[id] = Tuple2(BulletEntity(text: value, checked: bullet.item1.checked), bullet.item2);
                _bullets = b.build();
              });
            }

            widget.onChanged(_bullets.map((bullet) {
              final text = bullet.item1.text.trimLeft();
              final checked = bullet.item1.checked;
              return BulletEntity(text: text, checked: checked);
            }).toList());
          },
          onSubmitted: (result) {
            final id = _bullets.indexOf(bullet);
            setState(() {
              _bullets = _bullets.rebuild((b) => b
                ..insert(
                    id + 1,
                    Tuple2(
                      BulletEntity(text: ' ', checked: false),
                      FocusNode(),
                    )));
            });

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
  final bool checked;
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
    this.checked = false,
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
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLengthEnforced,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle().copyWith(
          color: widget.checked ? ColorfulApp.of(context).colors.medium : AppColors.black1,
          fontSize: widget.fontSize,
          decoration: widget.checked ? TextDecoration.lineThrough : null,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle().copyWith(
            color: ColorfulApp.of(context).colors.medium,
            fontSize: widget.fontSize,
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
