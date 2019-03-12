import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/shared/widgets/todo_avatar.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onTileTap;
  final VoidCallback onFavoriteTap;
  final bool showNotification;
  final bool isFinished;

  const TodoTile({
    Key key,
    @required this.todo,
    @required this.onTileTap,
    this.onFavoriteTap,
    this.showNotification,
    this.isFinished = false,
  })  : assert(todo != null),
        assert(onTileTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(width: 12.0),
      TodoAvatar(
        text: todo.name,
        isLarge: false,
        showNotification: showNotification ?? todo.notificationDate != null,
        isFinished: isFinished,
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          todo.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];

    if (onFavoriteTap != null) {
      children.add(_Favorite(
        initialState: todo.isFavorite,
        onTap: onFavoriteTap,
      ));
    } else {
      children.add(const SizedBox(width: 12.0));
    }

    return GestureDetector(
      onTap: onTileTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 56.0,
        child: Row(children: children),
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
    final duration = const Duration(milliseconds: 250);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });

        // Handle onTap callback when animation is finished
        Future.delayed(duration, widget.onTap);
      },
      child: Container(
        // Tap area
        padding: const EdgeInsets.all(12.0),
        child: AnimatedCrossFade(
          firstChild: _buildIcon(Icons.star_border),
          secondChild: _buildIcon(Icons.star),
          duration: duration,
          crossFadeState: _isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 26.0,
      color: _isActive ? ColorfulApp.of(context).colors.medium : ColorfulApp.of(context).colors.bright,
    );
  }
}
