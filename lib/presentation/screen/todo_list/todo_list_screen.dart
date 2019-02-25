import 'package:deer/domain/entity/tags.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/app.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/archive_list/archive_list_screen.dart';
import 'package:deer/presentation/screen/calendar/calendar_screen.dart';
import 'package:deer/presentation/screen/privacy.dart';
import 'package:deer/presentation/screen/todo_detail/todo_detail_screen.dart';
import 'package:deer/presentation/screen/todo_list/todo_list_actions.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box_decoration.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/dialogs.dart';
import 'package:deer/presentation/shared/widgets/dropdown.dart' as CustomDropdown;
import 'package:deer/presentation/shared/widgets/label.dart';
import 'package:deer/presentation/shared/widgets/reorderable_list.dart' as CustomList;
import 'package:deer/presentation/shared/widgets/tile.dart';
import 'package:deer/presentation/shared/widgets/todo_adder.dart';
import 'package:deer/utils/notification_utils.dart';
import 'package:deer/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'todo_list_bloc.dart';
import 'todo_list_state.dart';

enum MenuEntry { calendar, colors, privacy }

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
  ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();
    _bloc = TodoListBloc();
    _todoNameController = TextEditingController();
    _listScrollController = ScrollController();

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

    // Auto-scrolls to bottom of the ListView
    if (todo.name.trim().isNotEmpty) {
      // Because sometimes last item is skipped (see below)
      final lastItemExtent = 60.0;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _listScrollController.animateTo(
          _listScrollController.position.maxScrollExtent + lastItemExtent,
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

  void _showCalendar() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CalendarScreen(),
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
      case MenuEntry.calendar:
        _showCalendar();
        break;
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
                  value: MenuEntry.calendar,
                  child: Text('Calendar View'),
                ),
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
                : CustomList.ReorderableListView(
                    scrollController: _listScrollController,
                    onReorder: (oldIndex, newIndex) {
                      _bloc.actions.add(ReorderTodo(oldIndex: oldIndex, newIndex: newIndex));
                    },
                    children: state.todos.map((todo) {
                      return Dismissible(
                        key: Key(todo.addedDate.toIso8601String()),
                        background: _buildDismissibleBackground(leftToRight: true),
                        secondaryBackground: _buildDismissibleBackground(leftToRight: false),
                        onDismissed: (_) => _archiveTodo(todo),
                        child: TodoTile(
                          todo: todo,
                          onTileTap: () => _showDetails(todo),
                          onFavoriteTap: () => _favoriteTodo(todo),
                        ),
                      );
                    }).toList(),
                  ),
          ),
          TodoAdder(
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

// For disabling scroll 'glow'. Wrap the `ListView` with `ScrollConfiguration`
//----------
// class _NoHighlightBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }
