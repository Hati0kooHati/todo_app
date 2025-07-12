import 'package:todo_app/utilities/format_date.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Todo {
  final String uid;
  final String createdAt;

  String text;
  bool isDone;

  Todo({required this.text, this.isDone = false, String? createdAt, String? id})
    : uid = id ?? uuid.v4(),
      createdAt = createdAt ?? formatDate(DateTime.now());
}
