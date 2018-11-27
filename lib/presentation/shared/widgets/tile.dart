import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';

class TodoTile extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onTap;

  const TodoTile({
    Key key,
    @required this.todo,
    @required this.onTap,
  })  : assert(todo != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 12.0),
            TodoAvatar(text: todo.name),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                todo.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8.0),
            _Favorite(
              initialState: false,
              onTap: () {},
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}

class _Favorite extends StatefulWidget {
  final bool initialState;
  final VoidCallback onTap;

  _Favorite({
    Key key,
    this.initialState = false,
    @required this.onTap,
  })  : assert(onTap != null),
        super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<_Favorite> {
  bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });

        widget.onTap();
      },
      child: Container(
        // Tap area
        padding: const EdgeInsets.all(4.0),
        child: AnimatedCrossFade(
          firstChild: _buildIcon(Icons.star_border),
          secondChild: _buildIcon(Icons.star),
          duration: const Duration(milliseconds: 250),
          crossFadeState: _isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 26.0,
      // TODO: consider `colors.dark` for icons
      color: ColorfulApp.of(context).colors.medium,
    );
  }
}
