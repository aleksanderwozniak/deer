import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasking/domain/entity/tags.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/screen/archive_list/archive_list_screen.dart';
import 'package:tasking/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:tasking/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:tasking/presentation/shared/helper/date_formatter.dart';
import 'package:tasking/presentation/shared/resources.dart';
import 'package:tasking/presentation/shared/widgets/box_decoration.dart';
import 'package:tasking/presentation/shared/widgets/buttons.dart';
import 'package:tasking/presentation/shared/widgets/dropdown.dart' as CustomDropdown;
import 'package:tasking/presentation/shared/widgets/tag_action_chip.dart';
import 'package:tasking/presentation/shared/widgets/tile.dart';

import 'todo_list_bloc.dart';
import 'todo_list_state.dart';

typedef void _AddTaskCallback(TodoEntity task);

class TodoListScreen extends StatefulWidget {
  final String title;

  const TodoListScreen({Key key, this.title})
      : assert(title != null),
        super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Place variables here
  TodoListBloc _bloc;
  TextEditingController _todoNameController;
  ScrollController _todoListScrollController;

  @override
  void initState() {
    super.initState();
    _bloc = TodoListBloc();
    _todoNameController = TextEditingController();
    _todoListScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _archiveTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.archive, todo: todo));
  }

  void _addTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.add, todo: todo));

    // [WIP] A workaround for `todoNameHasError`
    if (todo.name.trim().isNotEmpty) {
      // Because sometimes last item is skipped (see below)
      final lastItemExtent = 60.0;

      // Auto-scrolls to bottom of the ListView
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _todoListScrollController.animateTo(
          _todoListScrollController.position.maxScrollExtent + lastItemExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _showDetails(TodoEntity todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TodoDetailScreen(todo: todo, editable: true),
    ));
  }

  void _showArchive() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ArchiveListScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _bloc.initialState,
      stream: _bloc.state,
      builder: (context, snapshot) {
        return _buildUI(snapshot.data);
      },
    );
  }

  Widget _buildUI(TodoListState state) {
    // Build your root view here
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorfulApp.of(context).colors.dark),
        title: Text(widget.title),
        centerTitle: true,
        bottom: _buildFilter(state),
        leading: IconButton(
          icon: Icon(Icons.color_lens),
          tooltip: 'Change theme',
          // [WIP]
          onPressed: () => ColorfulApp.of(context).nextColorTheme(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done_all),
            tooltip: 'Archive',
            onPressed: _showArchive,
          ),
        ],
      ),
      body: SafeArea(top: true, bottom: true, child: _buildBody(state)),
    );
  }

  Widget _buildFilter(TodoListState state) {
    final filters = presetTags.toList();
    filters.insert(0, 'All');

    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Filter by:'),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: roundedShape(context),
                child: CustomDropdown.DropdownButtonHideUnderline(
                  child: CustomDropdown.DropdownButton<String>(
                    isDense: true,
                    value: state.filter,
                    items: filters
                        .map((f) => CustomDropdown.DropdownMenuItem<String>(
                              child: Text(f),
                              value: f,
                            ))
                        .toList(),
                    onChanged: (filter) => _bloc.actions.add(FilterBy(filter: filter)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(TodoListState state) {
    return Container(
      decoration: BoxDecoration(gradient: ColorfulApp.of(context).colors.brightGradient),
      child: Column(
        children: <Widget>[
          Expanded(
            child: state.todos.length == 0
                // TODO: beautify
                ? Center(child: Text('Todo list is empty!'))
                : ListView.builder(
                    itemCount: state.todos.length,
                    controller: _todoListScrollController,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return Dismissible(
                        key: Key(todo.addedDate.toIso8601String()),
                        background: _buildDismissibleBackground(leftToRight: true),
                        secondaryBackground: _buildDismissibleBackground(leftToRight: false),
                        onDismissed: (_) => _archiveTodo(todo),
                        child: TodoTile(
                          todo: todo,
                          onTap: () => _showDetails(todo),
                        ),
                      );
                    },
                  ),
          ),
          _TodoAdder(
            onAdd: _addTodo,
            showError: state.todoNameHasError,
            todoNameController: _todoNameController,
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleBackground({@required bool leftToRight}) {
    final alignment = leftToRight ? Alignment.centerLeft : Alignment.centerRight;
    final colors =
        leftToRight ? [ColorfulApp.of(context).colors.bright, AppColors.white1] : [AppColors.white1, ColorfulApp.of(context).colors.bright];

    return Container(
      child: Text(
        'Done',
        style: TextStyle().copyWith(color: AppColors.white1, fontSize: 20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}

class _TodoAdder extends StatefulWidget {
  final TextEditingController todoNameController;
  final _AddTaskCallback onAdd;
  final bool showError;

  const _TodoAdder({
    Key key,
    @required this.todoNameController,
    @required this.onAdd,
    @required this.showError,
  })  : assert(todoNameController != null),
        assert(onAdd != null),
        assert(showError != null),
        super(key: key);

  @override
  _TodoAdderState createState() => _TodoAdderState();
}

class _TodoAdderState extends State<_TodoAdder> {
  final double _collapsedHeight = 97.0;
  final double _expandedHeight = 294.0;

  bool _isExpanded;
  double _height;
  DateTime _dueDate;
  List<String> _tags;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    _tags = [];
    _height = _collapsedHeight;

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animate(showExpansion: false);
      }
    });
  }

  void _selectDate() async {
    // set initialDate to tomorrow by default
    final tomorrow = DateTime.now().add(Duration(days: 1));

    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? tomorrow,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    // Null check prevents user from resetting dueDate.
    // I've decided the reset is a wanted feature.
    // if (date != null) {
    setState(() {
      _dueDate = date;
    });
  }

  void _toggleTag(String tag) {
    if (_tags.contains(tag)) {
      _tags.remove(tag);
    } else {
      _tags.add(tag);
    }
  }

  void _animate({bool showExpansion}) {
    setState(() {
      _isExpanded = showExpansion ?? !_isExpanded;
      _height = _isExpanded ? _expandedHeight : _collapsedHeight;

      if (_isExpanded) {
        _focusNode.unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(height: 4.0),
      _buildHeader(),
      const SizedBox(height: 4.0),
      _buildAdder(),
      const SizedBox(height: 16.0),
      Container(
        color: ColorfulApp.of(context).colors.dark,
        height: 1.0,
      ),
    ];

    if (_isExpanded) {
      children.add(_buildBody());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      constraints: BoxConstraints.expand(height: _height),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10.0)],
        color: AppColors.white1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (_) {
        _animate();
      },
      child: Center(
        child: Icon(
          _isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
          color: ColorfulApp.of(context).colors.darkest,
        ),
      ),
    );
  }

  Widget _buildAdder() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(width: 18.0),
        Expanded(
          child: TextField(
            focusNode: _focusNode,
            controller: widget.todoNameController,
            maxLength: 50,
            maxLengthEnforced: true,
            maxLines: null,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle().copyWith(fontSize: 16.0, color: AppColors.black1),
            decoration: InputDecoration.collapsed(
              border: UnderlineInputBorder(),
              hintText: widget.showError ? 'Name can\'t be empty' : 'New Todo',
              hintStyle: TextStyle().copyWith(
                color: widget.showError ? ColorfulApp.of(context).colors.darkest : ColorfulApp.of(context).colors.medium,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        RoundButton(
          text: 'Add',
          onPressed: () {
            widget.onAdd(_buildTodo());
            widget.todoNameController.clear();
          },
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        // ListView disables overflow error. If scrolling becomes desired, remove `NeverScrollableScrollPhysics`
        // NOTE: overflow error happens just during animation; also it is not visible on Release build.
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 18.0),
            _buildTags(),
            const SizedBox(height: 18.0),
            _buildDate(),
          ],
        ),
      ),
    );
  }

  Widget _buildDate() {
    return GestureDetector(
      onTap: _selectDate,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: roundedShape(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Due by:',
              style: TextStyle().copyWith(fontSize: 12.0, color: ColorfulApp.of(context).colors.dark),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    DateFormatter.safeFormatDays(_dueDate),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  DateFormatter.safeFormatFull(_dueDate),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags() {
    final children = presetTags
        .map((tag) => TagActionChip(
              title: tag,
              initiallySelected: _tags.contains(tag),
              onTap: () => _toggleTag(tag),
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16.0,
        runSpacing: 12.0,
        children: children,
      ),
    );
  }

  TodoEntity _buildTodo() {
    _tags.sort();

    return TodoEntity(
      name: widget.todoNameController.text,
      tags: BuiltList(_tags),
      addedDate: DateTime.now(),
      dueDate: _dueDate,
    );
  }
}

// For disabling scroll 'glow'. Wrap the `ListView` with `ScrollConfiguration`
//----------
// class _NoHighlightBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
