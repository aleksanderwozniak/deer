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

class ToggleTag {
  final String tag;

  const ToggleTag({
    this.tag,
  });
}
