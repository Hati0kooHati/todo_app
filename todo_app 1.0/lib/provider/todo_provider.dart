import 'package:flutter/material.dart';

import 'package:todo_app/model/task.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> todoList = [
    Todo(todoText: "Buy groceries for the week"),
    Todo(todoText: "Finish the mobile app UI design"),
    Todo(todoText: "Call mom and check on her"),
    Todo(todoText: "Read 20 pages of a new book"),
    Todo(todoText: "Clean the kitchen and do the dishes"),
    Todo(todoText: "Reply to important work emails"),
    Todo(todoText: "Water the plants in the balcony"),
    Todo(todoText: "Plan weekend trip with friends"),
    Todo(todoText: "Backup files to external hard drive"),
    Todo(todoText: "Go for a 30-minute morning walk"),
  ];

  void addTask({required String? todoText, required int insertIndex}) {
    if (todoText != null && todoText.trim().isNotEmpty) {
      todoList.insert(insertIndex, Todo(todoText: todoText));
      notifyListeners();
    }
  }

  void deleteTask(Todo todo) {
    todoList.remove(todo);
    notifyListeners();
  }

  void makeTaskDone(Todo todo) {
    todoList[todoList.indexOf(todo)].isDone = true;
    notifyListeners();
  }

  void returnTodo({required Todo todo, required insertIndex}) {
    todoList.insert(insertIndex, todo);
    notifyListeners();
  }

  void changeTodo({required Todo todo, required newTodoText}) {
    todoList[todoList.indexOf(todo)].todoText = newTodoText;
    notifyListeners();
  }
}
