import 'package:todo_app/model/todo.dart';

Map<String, dynamic> todoToMap(Todo todo) {
  return {
    "id": todo.id,
    "text": todo.text,
    "createdAt": todo.createdAt,
    "isDone": todo.isDone ? 1 : 0,
  };
}
