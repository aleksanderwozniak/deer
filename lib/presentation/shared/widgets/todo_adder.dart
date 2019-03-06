import 'package:built_collection/built_collection.dart';
import 'package:deer/domain/entity/tags.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box_decoration.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/tag_action_chip.dart';
import 'package:deer/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:rxdart/rxdart.dart';

typedef void _OnTaskAdded(TodoEntity task);
typedef void _OnFormatChanged(TodoAdderFormat format);

enum TodoAdderFormat { folded, expanded, keyboardVisible }

class TodoAdder extends StatefulWidget {
  final TextEditingController todoNameController;
  final _OnTaskAdded onAdd;
  final _OnFormatChanged onFormatChanged;
  final bool showError;
  final DateTime scheduledDate;

  const TodoAdder({
    Key key,
    @required this.todoNameController,
    @required this.onAdd,
    @required this.showError,
    this.onFormatChanged,
    this.scheduledDate,
  })  : assert(todoNameController != null),
        assert(onAdd != null),
        assert(showError != null),
        super(key: key);

  @override
  _TodoAdderState createState() => _TodoAdderState();
}

class _TodoAdderState extends State<TodoAdder> {
  final double _collapsedHeight = 99.0;
  final double _expandedHeight = 295.0;
  final int _expansionMillis = 250;
  final int _switchFocusMillis = 0;

  int _millis;
  double _height;
  DateTime _notificationDate;
  List<String> _tags;
  FocusNode _focusNode;
  BehaviorSubject<TodoAdderFormat> _expansionFormatSubject;
  KeyboardVisibilityNotification _keyboardNotification;
  int _keyboardSubscriptionId;

  @override
  void initState() {
    super.initState();
    _expansionFormatSubject = BehaviorSubject.seeded(TodoAdderFormat.folded);
    _tags = [];
    _height = _collapsedHeight;
    _millis = _expansionMillis;
    _focusNode = FocusNode();

    _keyboardNotification = KeyboardVisibilityNotification();
    _keyboardSubscriptionId = _keyboardNotification.addNewListener(
      onShow: () {
        _millis = _switchFocusMillis;
        _expansionFormatSubject.add(TodoAdderFormat.keyboardVisible);
      },
      onHide: () {
        _millis = _expansionMillis;

        if (_expansionFormatSubject.value == TodoAdderFormat.keyboardVisible) {
          _expansionFormatSubject.add(TodoAdderFormat.folded);
        }
      },
    );

    _expansionFormatSubject.stream.distinct().listen((format) {
      _animate(format);

      if (widget.onFormatChanged != null) {
        widget.onFormatChanged(format);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _expansionFormatSubject.close();
    _keyboardNotification.removeListener(_keyboardSubscriptionId);
    _focusNode.dispose();
  }

  void _setupNotification() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _notificationDate ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    if (date == null) {
      // clear when dialog is dismissed
      setState(() {
        _notificationDate = null;
      });
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_notificationDate ?? DateTime.now()),
    );

    if (time == null) {
      setState(() {
        _notificationDate = null;
      });
      return;
    }

    setState(() {
      _notificationDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _toggleTag(String tag) {
    if (_tags.contains(tag)) {
      _tags.remove(tag);
    } else {
      _tags.add(tag);
    }
  }

  void _animate(TodoAdderFormat format) {
    if (format != TodoAdderFormat.keyboardVisible && _focusNode.hasFocus) {
      _focusNode.unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      Future.delayed(const Duration(milliseconds: 150), () {
        _runAnimation(format);
      });
    } else {
      _runAnimation(format);
    }
  }

  void _runAnimation(TodoAdderFormat format) {
    setState(() {
      _height = format == TodoAdderFormat.expanded ? _expandedHeight : _collapsedHeight;
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

    if (_expansionFormatSubject.value == TodoAdderFormat.expanded) {
      children.add(_buildBody());
    }

    return WillPopScope(
      onWillPop: () {
        if (_expansionFormatSubject.value != TodoAdderFormat.folded) {
          _expansionFormatSubject.add(TodoAdderFormat.folded);
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
        _expansionFormatSubject.add(
          _expansionFormatSubject.value == TodoAdderFormat.expanded ? TodoAdderFormat.folded : TodoAdderFormat.expanded,
        );
      },
      child: Center(
        child: Icon(
          _expansionFormatSubject.value == TodoAdderFormat.expanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
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
            _buildNotification(),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildNotification() {
    return GestureDetector(
      onTap: _setupNotification,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: roundedShape(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Notification:',
              style: TextStyle().copyWith(fontSize: 12.0, color: ColorfulApp.of(context).colors.bleak),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(width: 20.0),
                Expanded(
                  child: Text(
                    DateFormatter.safeFormatDays(_notificationDate),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  DateFormatter.safeFormatFullWithTime(_notificationDate),
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

    final todo = TodoEntity(
      name: widget.todoNameController.text,
      tags: BuiltList(_tags),
      addedDate: DateTime.now(),
      notificationDate: _notificationDate,
      dueDate: widget.scheduledDate,
    );

    if (todo.notificationDate != null) {
      scheduleNotification(todo);
    }

    return todo;
  }
}
