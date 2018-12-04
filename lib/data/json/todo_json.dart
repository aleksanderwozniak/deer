import 'package:flutter/foundation.dart';
import 'package:tasking/data/json/bullet_json.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/utils/string_utils.dart';

class TodoJson {
  final String name;
  final String description;
  final List<BulletJson> bulletPoints;
  final List<String> tags;
  final TodoStatus status;
  final bool isFavorite;
  final DateTime addedDate;
  final DateTime dueDate;
  final DateTime finishedDate;
  final DateTime notificationDate;

  const TodoJson({
    @required this.name,
    this.description,
    this.bulletPoints,
    this.tags,
    @required this.status,
    this.isFavorite,
    @required this.addedDate,
    this.dueDate,
    this.finishedDate,
    this.notificationDate,
  })  : assert(name != null),
        assert(status != null),
        assert(addedDate != null);

  static TodoJson parse(Map<String, dynamic> inputJson) {
    final stringBullets = inputJson['bulletPoints'] as List;
    final List<BulletJson> decodedBullets = stringBullets.map((e) => BulletJson.parse(e)).toList();
    final tags = (inputJson['tags'] as List)?.cast<String>();

    return TodoJson(
      name: inputJson['name'],
      description: inputJson['description'],
      bulletPoints: inputJson['bulletPoints'] != null ? decodedBullets : null,
      tags: inputJson['tags'] != null ? tags : const [],
      status: stringToEnum(inputJson['status'], TodoStatus.values),
      isFavorite: inputJson['isFavorite'],
      addedDate: DateTime.parse(inputJson['addedDate']),
      dueDate: inputJson['dueDate'] != null ? DateTime.parse(inputJson['dueDate']) : null,
      finishedDate: inputJson['finishedDate'] != null ? DateTime.parse(inputJson['finishedDate']) : null,
      notificationDate: inputJson['notificationDate'] != null ? DateTime.parse(inputJson['notificationDate']) : null,
    );
  }

  Map encode() {
    final bullets = bulletPoints.map((json) => json.encode()).toList();
    return {
      'name': name,
      'description': description,
      'bulletPoints': bullets,
      'tags': tags,
      'status': enumToString(status),
      'isFavorite': isFavorite,
      'addedDate': addedDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'finishedDate': finishedDate?.toIso8601String(),
      'notificationDate': notificationDate?.toIso8601String(),
    };
  }
}
