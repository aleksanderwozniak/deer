import 'package:built_collection/built_collection.dart';
import 'package:deer/domain/entity/tags.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/app.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/archive_list/archive_list_screen.dart';
import 'package:deer/presentation/screen/privacy.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box_decoration.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/dialogs.dart';
import 'package:deer/presentation/shared/widgets/dropdown.dart' as CustomDropdown;
import 'package:deer/presentation/shared/widgets/label.dart';
import 'package:deer/presentation/shared/widgets/tag_action_chip.dart';
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:deer/utils/notification_utils.dart';
import 'package:deer/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'todo_list_bloc.dart';
import 'todo_list_state.dart';

typedef void _AddTaskCallback(TodoEntity task);

enum MenuEntry { colors, privacy }

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

    final initSettings = InitializationSettings(
      AndroidInitializationSettings('deer_logo'),
      IOSInitializationSettings(),
    );

    notificationManager.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  // Place methods here
  void _archiveTodo(TodoEntity todo) {
    cancelNotification(todo);
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

  void _favoriteTodo(TodoEntity todo) {
    _bloc.actions.add(PerformOnTodo(operation: Operation.favorite, todo: todo));
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

  void _selectColorTheme() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SimpleDialog(
            title: Text(
              'Select Color Theme',
              style: TextStyle().copyWith(fontSize: 18.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(width: 1.0, color: ColorfulApp.of(context).colors.bleak),
            ),
            children: ColorfulTheme.values
                .skip(1)
                .map((color) => SimpleDialogOption(
                      child: _buildColorDialogOption(
                        text: capitalize(enumToString(color)),
                        mainColor: ColorfulApp.of(context).themeDataFromEnum(color).pale,
                        borderColor: ColorfulApp.of(context).themeDataFromEnum(color).dark,
                      ),
                      onPressed: () => ColorfulApp.of(context).updateColorTheme(color),
                    ))
                .toList(),
          ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RoundedAlertDialog(
            title: 'Privacy Policy',
            content: SingleChildScrollView(
              child: Text(shortPrivacyPolicy, textAlign: TextAlign.center),
            ),
            actions: <Widget>[
              FlatRoundButton(
                text: 'Read more',
                onPressed: _showFullPrivacyPolicy,
              ),
              FlatRoundButton(
                text: 'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  void _showFullPrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PrivacyScreen(),
      fullscreenDialog: true,
    ));
  }

  void _onMenuEntryTapped(MenuEntry entry) {
    switch (entry) {
      case MenuEntry.colors:
        _selectColorTheme();
        break;
      case MenuEntry.privacy:
        _showPrivacyPolicyDialog();
        break;
    }
  }

  Future onSelectNotification(String payload) async {
    // Payload should never be null; check just to be sure
    if (payload != null) {
      final todos = await dependencies.todoInteractor.active.first;
      final notificationTodo = todos.firstWhere((e) => e.addedDate.toIso8601String().compareTo(payload) == 0);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoDetailScreen(todo: notificationTodo, editable: true),
        ),
      );
    }
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
        leading: PopupMenuButton(
          onSelected: _onMenuEntryTapped,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuEntry>>[
                const PopupMenuItem<MenuEntry>(
                  value: MenuEntry.colors,
                  child: Text('Color Theme'),
                ),
                const PopupMenuItem<MenuEntry>(
                  value: MenuEntry.privacy,
                  child: Text('Privacy Policy'),
                ),
              ],
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
    filters.insertAll(0, ['All', 'Favorite']);

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
                ? Center(
                    child: SingleChildScrollView(
                      child: buildCentralLabel(text: 'Todo list is empty!', context: context),
                    ),
                  )
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
                          onTileTap: () => _showDetails(todo),
                          onFavoriteTap: () => _favoriteTodo(todo),
                          hasNotification: todo.notificationDate != null,
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

  Widget _buildColorDialogOption({String text, Color mainColor, Color borderColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(text),
          Expanded(child: const SizedBox(width: 8.0)),
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mainColor,
              border: Border.all(color: borderColor),
            ),
          ),
        ],
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
  final double _collapsedHeight = 99.0;
  final double _expandedHeight = 295.0;
  final int _expansionMillis = 250;
  final int _switchFocusMillis = 0;

  int _millis;
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
    _millis = _expansionMillis;

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _millis = _switchFocusMillis;
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
    _isExpanded = showExpansion ?? !_isExpanded;

    if (_isExpanded) {
      _millis = _expansionMillis;
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
        Future.delayed(const Duration(milliseconds: 150), () {
          _runAnimation();
        });
      } else {
        _runAnimation();
      }
    } else {
      _runAnimation();
    }
  }

  void _runAnimation() {
    setState(() {
      _height = _isExpanded ? _expandedHeight : _collapsedHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(height: 4.0),
      _buildHeader(),
      _buildAdder(),
      const SizedBox(height: 6.0),
      Container(
        color: ColorfulApp.of(context).colors.bleak,
        height: 1.0,
      ),
    ];

    if (_isExpanded) {
      children.add(_buildBody());
    }

    // TODO: this might be in a wrong place, although it works perfectly
    return WillPopScope(
      onWillPop: () {
        if (_isExpanded) {
          _animate(showExpansion: false);
        } else {
          return Future(() => true);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: _millis),
        height: _height,
        constraints: BoxConstraints(minHeight: _height),
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
          color: ColorfulApp.of(context).colors.dark,
        ),
      ),
    );
  }

  Widget _buildAdder() {
    return SizedBox(
      height: 64.0,
      child: Row(
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
                  color: widget.showError ? ColorfulApp.of(context).colors.dark : ColorfulApp.of(context).colors.medium,
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
      ),
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
            const SizedBox(height: 18.0),
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
              'Due:',
              style: TextStyle().copyWith(fontSize: 12.0, color: ColorfulApp.of(context).colors.bleak),
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
