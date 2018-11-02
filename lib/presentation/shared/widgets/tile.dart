import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
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
    final children = [
      const SizedBox(width: 12.0),
      Expanded(
        child: Text(
          todo.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(width: 12.0),
    ];

    if (todo.name.isNotEmpty) {
      children.insertAll(1, [
        TodoAvatar(text: todo.name),
        const SizedBox(width: 8.0),
      ]);
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: children,
        ),
      ),
    );
  }
}
