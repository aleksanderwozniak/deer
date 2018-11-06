import 'package:flutter/material.dart';
import 'package:tasking/presentation/shared/resources.dart';

class BulletListEdit extends StatefulWidget {
  final List<String> initialBullets;
  final List<String> listholder;

  const BulletListEdit({
    Key key,
    this.initialBullets,
    this.listholder,
  }) : super(key: key);

  @override
  _BulletListEditState createState() => _BulletListEditState();
}

class _BulletListEditState extends State<BulletListEdit> {
  List<_IndexedString> _bullets;
  bool _autofocus;

  @override
  void initState() {
    super.initState();
    _bullets = widget.initialBullets
            ?.map((entry) => _IndexedString(
                  id: widget.initialBullets.indexOf(entry),
                  text: entry,
                ))
            ?.toList() ??
        List();
    _autofocus = false;
  }

  @override
  Widget build(BuildContext context) {
    final children = _bullets.map((bullet) {
      return _buildRow(bullet: bullet);
    }).toList();

    final id = children.length;
    children.add(_buildRow(
      bullet: _IndexedString(id: id, text: ''),
      autofocus: _autofocus,
    ));

    if (!_autofocus) {
      setState(() {
        _autofocus = true;
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildRow({@required _IndexedString bullet, bool autofocus = false}) {
    final id = bullet.id;

    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
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
            controller: TextEditingController(text: bullet.text),
            onSubmitted: (result) {
              if (result == '') {
                // this works :>
                setState(() {
                  _bullets.remove(bullet);
                });
              } else {
                final updatedBullet = _IndexedString(id: id, text: result);

                setState(() {
                  _bullets.insert(id, updatedBullet);
                  _bullets.removeAt(id + 1);
                });
              }

              widget.listholder.replaceRange(0, widget.listholder.length, _bullets.map((b) => b.text));
            },
            // onChanged: (result) {
            //   //------ Not working -------
            //   // simulate removing an empty string
            //   if (result == '') {
            //     setState(() {
            //       _bullets.removeAt(id);
            //     });
            //   }
            // },
          ),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }
}

class _IndexedString {
  final int id;
  final String text;

  const _IndexedString({
    @required this.id,
    @required this.text,
  });
}

//------------------
// import 'package:flutter/material.dart';

// class BulletListEdit extends StatefulWidget {
//   @override
//   _BulletListEditState createState() => _BulletListEditState();
// }

// class _BulletListEditState extends State<BulletListEdit> {
//   TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: '· ');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _controller,
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//       onChanged: (text) {
//         // if (text.endsWith('\n')) {
//         //   setState(() {
//         //     _controller.text += '· ';
//         //   });
//         // }
//       },
//     );
//   }
// }
