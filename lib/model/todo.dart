import 'package:todo_app/utilities/format_date.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Todo {
  final String id;
  final String createdAt;

  final String text;
  final bool isDone;

  Todo({required this.text, this.isDone = false, String? createdAt, String? id})
    : id = id ?? uuid.v4(),
      createdAt = createdAt ?? formatDate(DateTime.now());

  Todo copyWith({String? id, String? createdAt, String? text, bool? isDone}) {
    return Todo(
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
    );
  }
}
