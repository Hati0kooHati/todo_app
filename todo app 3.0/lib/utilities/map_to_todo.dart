import 'package:todo_app/models/todo.dart';

Todo mapToTodo(Map<String, dynamic> todoMap) {
  return Todo(
    text: todoMap["text"],
    createdAt: todoMap["createdAt"],
    id: todoMap["id"],
    isDone: todoMap["isDone"] == 1 ? true : false,
  );
}
