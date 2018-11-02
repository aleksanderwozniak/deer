import 'package:flutter/foundation.dart';

class TodoJson {
  final String name;
  final String description;
  final DateTime addedDate;
  final DateTime dueDate;

  const TodoJson({
    @required this.name,
    this.description,
    @required this.addedDate,
    this.dueDate,
  })  : assert(name != null),
        assert(addedDate != null);

  static TodoJson parse(Map<String, dynamic> json) {
    return TodoJson(
      name: json['name'],
      description: json['description'],
      addedDate: DateTime.parse(json['addedDate']),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  Map encode() {
    return {
      'name': name,
      'description': description,
      'addedDate': addedDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
