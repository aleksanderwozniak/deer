import 'dart:io';

class UpdateField {
  final FieldKey key;
  final dynamic value;

  const UpdateField({
    this.key,
    this.value,
  });
}

enum FieldKey {
  name,
  description,
  bulletPoints,
  dueDate,
  notificationDate,
}

class SetImage {
  final File image;
  final String localPath;

  const SetImage({
    this.image,
    this.localPath,
  });
}

class ToggleTag {
  final String tag;

  const ToggleTag({
    this.tag,
  });
}
