import 'package:flutter/foundation.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/utils/string_utils.dart';

class TodoJson {
  final String name;
  final String description;
  final List<String> bulletPoints;
  final TodoStatus status;
  final DateTime addedDate;
  final DateTime dueDate;

  const TodoJson({
    @required this.name,
    this.description,
    this.bulletPoints,
    @required this.status,
    @required this.addedDate,
    this.dueDate,
  })  : assert(name != null),
        assert(status != null),
        assert(addedDate != null);

  static TodoJson parse(Map<String, dynamic> json) {
    return TodoJson(
      name: json['name'],
      description: json['description'],
      bulletPoints: json['bulletPoints'] != null ? _parseList(json['bulletPoints']) : null,
      status: stringToEnum(json['status'], TodoStatus.values),
      addedDate: DateTime.parse(json['addedDate']),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  Map encode() {
    return {
      'name': name,
      'description': description,
      'bulletPoints': bulletPoints?.toString() ?? null,
      'status': enumToString(status),
      'addedDate': addedDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  static List<String> _parseList(String codedList) {
    return codedList.substring(1, codedList.length - 1).split(', ');
  }
}
