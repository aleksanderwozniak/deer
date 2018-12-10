import 'dart:io';

import 'package:deer/domain/entity/tags.dart';
import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/colorful_app.dart';
import 'package:deer/presentation/screen/todo_edit/todo_edit_actions.dart';
import 'package:deer/presentation/screen/todo_edit/todo_edit_bloc.dart';
import 'package:deer/presentation/screen/todo_edit/todo_edit_state.dart';
import 'package:deer/presentation/shared/helper/date_formatter.dart';
import 'package:deer/presentation/shared/resources.dart';
import 'package:deer/presentation/shared/widgets/box.dart';
import 'package:deer/presentation/shared/widgets/buttons.dart';
import 'package:deer/presentation/shared/widgets/editable_bullet_list.dart';
import 'package:deer/presentation/shared/widgets/tag_action_chip.dart';
import 'package:deer/utils/notification_utils.dart';
import 'package:deer/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TodoEditScreen extends StatefulWidget {
  final TodoEntity todo;

  TodoEditScreen({Key key, @required this.todo})
      : assert(todo != null),
        super(key: key);

  @override
  _TodoEditScreenState createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  TodoEditBloc _bloc;

  FocusNode _nameFocusNode;
  FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _bloc = TodoEditBloc(todo: widget.todo);

    _nameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  void _selectDate(TodoEditState state) async {
    // set initialDate to tomorrow by default
    final tomorrow = DateTime.now().add(Duration(days: 1));

    final date = await showDatePicker(
      context: context,
      initialDate: state.todo.dueDate ?? tomorrow,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    // Null check prevents user from resetting dueDate.
    // I've decided the reset is a wanted feature.
    // if (date != null) {
    _bloc.actions.add(UpdateField(key: FieldKey.dueDate, value: date));
  }

  void _setupNotification(TodoEditState state) async {
    final date = await showDatePicker(
      context: context,
      initialDate: state.todo.notificationDate ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );

    if (date == null) {
      // clear when dialog is dismissed
      _bloc.actions.add(UpdateField(key: FieldKey.notificationDate, value: null));
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.todo.notificationDate ?? DateTime.now()),
    );

    if (time == null) {
      _bloc.actions.add(UpdateField(key: FieldKey.notificationDate, value: null));
      return;
    }

    final notificationDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    _bloc.actions.add(UpdateField(key: FieldKey.notificationDate, value: notificationDate));
  }

  void _chooseImageSource() async {
    final ImageSource source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
            content: Text('Choose image source'),
            actions: <Widget>[
              FlatButton(
                child: Text('Gallery'),
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
              ),
              FlatButton(
                child: Text('Camera'),
                onPressed: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
    );

    if (source != null) {
      _pickImage(source);
    }
  }

  void _pickImage(ImageSource source) async {
    final File image = await ImagePicker.pickImage(source: source);

    // null values (aka dismissing dialog) will remove the image
    final path = image != null ? await _localPath : null;
    _bloc.actions.add(SetImage(image: image, localPath: path));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _zoomImage(File image) {
    if (image != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Image.file(image)));
    }
  }

  File _getImageSrc(TodoEditState state) {
    if (state.image != null) {
      return state.image;
    } else if (!isBlank(state.todo.imagePath)) {
      return File(state.todo.imagePath);
    } else {
      return null;
    }
  }

  void _submit(TodoEditState state) async {
    if (!state.todoNameHasError) {
      if (state.todo.notificationDate == null) {
        cancelNotification(state.todo);
      } else if (widget.todo.notificationDate == null || widget.todo.notificationDate.compareTo(state.todo.notificationDate) != 0) {
        // Schedule a notification only when date has been set to a new (different) value
        scheduleNotification(state.todo);
      }

      if (!isBlank(state.todo.imagePath)) {
        // Save image file in correct path
        await state.image.copy(state.todo.imagePath);
      }

      Navigator.of(context).pop(state.todo);
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

  Widget _buildUI(TodoEditState state) {
    return WillPopScope(
      onWillPop: () async {
        _nameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorfulApp.of(context).colors.bleak),
          centerTitle: true,
          title: Text('Edit Todo'),
        ),
        body: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(TodoEditState state) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              _buildName(state),
              _buildDescription(state),
              _buildTags(state),
              _buildBulletPoints(state),
              _buildImage(state),
              _buildNotification(state),
              _buildDate(state),
            ],
          ),
        ),
        BottomButton(
          text: 'Save',
          onPressed: () => _submit(state),
        ),
      ],
    );
  }

  Widget _buildName(TodoEditState state) {
    return ShadedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: _TextField(
          focusNode: _nameFocusNode,
          showError: state.todoNameHasError,
          value: state.todo.name,
          textAlign: TextAlign.center,
          inputAction: TextInputAction.done,
          maxLength: 50,
          maxLengthEnforced: true,
          maxLines: null,
          fontSize: 20.0,
          hint: state.todoNameHasError ? 'Name can\'t be empty' : 'Todo\'s name',
          onChanged: (value) => _bloc.actions.add(UpdateField(key: FieldKey.name, value: value)),
        ),
      ),
    );
  }

  Widget _buildDescription(TodoEditState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Description',
            style: TextStyle().copyWith(color: ColorfulApp.of(context).colors.bleak, fontSize: 12.0),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _TextField(
              focusNode: _descriptionFocusNode,
              maxLines: null,
              value: state.todo.description,
              hint: 'Todo\'s description',
              onChanged: (value) => _bloc.actions.add(UpdateField(key: FieldKey.description, value: value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(TodoEditState state) {
    final children = presetTags
        .map((tag) => TagActionChip(
              title: tag,
              initiallySelected: state.todo.tags.contains(tag),
              onTap: () => _bloc.actions.add(ToggleTag(tag: tag)),
            ))
        .toList();

    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Tags',
            style: TextStyle().copyWith(color: ColorfulApp.of(context).colors.bleak, fontSize: 12.0),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.0,
              runSpacing: 12.0,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints(TodoEditState state) {
    return ShadedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Bullet points',
            style: TextStyle().copyWith(color: ColorfulApp.of(context).colors.bleak, fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: EditableBulletList(
              initialBulletPoints: state.todo.bulletPoints.toList(),
              onChanged: (bullets) => _bloc.actions.add(UpdateField(key: FieldKey.bulletPoints, value: bullets)),
            ),
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  Widget _buildImage(TodoEditState state) {
    final src = _getImageSrc(state);
    final image = src != null ? Image.file(src, filterQuality: FilterQuality.low) : null;

    return ShadedBox(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8.0),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _zoomImage(state.image),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: 200.0,
              height: 200.0,
              child: image,
            ),
          ),
          FlatButton(
            child: Text(
              'Select an image',
              style: TextStyle().copyWith(color: ColorfulApp.of(context).colors.bleak, fontSize: 12.0),
            ),
            onPressed: _chooseImageSource,
          ),
        ],
      ),
    );
  }

  Widget _buildNotification(TodoEditState state) {
    return ShadedBox(
      child: GestureDetector(
        onTap: () => _setupNotification(state),
        behavior: HitTestBehavior.opaque,
        child: Column(
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
                Text(
                  DateFormatter.safeFormatDays(state.todo.notificationDate),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    DateFormatter.safeFormatFullWithTime(state.todo.notificationDate),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(TodoEditState state) {
    return ShadedBox(
      child: GestureDetector(
        onTap: () => _selectDate(state),
        behavior: HitTestBehavior.opaque,
        child: Column(
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
                Text(
                  DateFormatter.safeFormatDays(state.todo.dueDate),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    DateFormatter.safeFormatFull(state.todo.dueDate),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final TextAlign textAlign;
  final String value;
  final String hint;
  final double fontSize;
  final int maxLines;
  final int maxLength;
  final bool maxLengthEnforced;
  final bool showError;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const _TextField({
    Key key,
    this.focusNode,
    this.inputAction,
    this.textAlign = TextAlign.start,
    this.value,
    this.hint,
    this.fontSize = 14.0,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.showError = false,
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
      widget.onChanged(controller.value.text);
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
      child: TextField(
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: controller,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLengthEnforced,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle().copyWith(
          color: AppColors.black1,
          fontSize: widget.fontSize,
        ),
        decoration: InputDecoration.collapsed(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle().copyWith(
            color: widget.showError ? ColorfulApp.of(context).colors.dark : ColorfulApp.of(context).colors.medium,
            fontSize: widget.fontSize,
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
