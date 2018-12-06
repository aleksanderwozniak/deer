import 'package:deer/domain/entity/todo_entity.dart';
import 'package:deer/presentation/app.dart';
import 'package:deer/utils/string_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String _kNotificationChannelId = 'ScheduledNotification';
const String _kNotificationChannelName = 'Scheduled Notification';
const String _kNotificationChannelDescription = 'Pushes a notification at a specified date';

Future scheduleNotification(TodoEntity todo) async {
  final notificationDetails = NotificationDetails(
    AndroidNotificationDetails(
      _kNotificationChannelId,
      _kNotificationChannelName,
      _kNotificationChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
    ),
    IOSNotificationDetails(),
  );

  await notificationManager.schedule(
    _dateToUniqueInt(todo.addedDate),
    todo.name,
    !isBlank(todo.description) ? todo.description : todo.bulletPoints.map((b) => '- ${b.text}').join('    '),
    todo.notificationDate,
    notificationDetails,
    payload: todo.addedDate.toIso8601String(),
  );
}

void cancelNotification(TodoEntity todo) async {
  final id = _dateToUniqueInt(todo.addedDate);
  await notificationManager.cancel(id);
}

int _dateToUniqueInt(DateTime date) {
  return date.year * 10000 + date.minute * 100 + date.second;
}
