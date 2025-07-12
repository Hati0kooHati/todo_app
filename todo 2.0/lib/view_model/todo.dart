import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo.dart';

import 'package:flutter/material.dart';

class TodoViewModel extends ChangeNotifier {
  final WidgetRef ref;

  TodoViewModel(this.ref) {
    ref.read(todoProvider.notifier).loadItems();
  }

  List<Todo> get todoList {
    return ref.watch(todoProvider);
  }

  void addTodo({required text}) {
    ref.read(todoProvider.notifier).addTodo(todo: Todo(text: text));
  }

  void deleteTodo({required Todo todo}) {
    ref.read(todoProvider.notifier).deleteTodo(todo);
  }

  void insertTodo({required Todo todo, required int index}) {
    ref.read(todoProvider.notifier).insertTodo(todo: todo, index: index);
  }

  void changeTodo({required Todo fromTodo, String? text, bool? isDone}) {
    ref
        .read(todoProvider.notifier)
        .changeTodo(todo: fromTodo, isDone: isDone, text: text);
  }

  void showDeleteInfo({required Todo todo, required BuildContext context}) {
    final int todoIndex = ref.read(todoProvider).indexOf(todo);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task has deleted"),
        action: SnackBarAction(
          label: "return",
          onPressed: () {
            insertTodo(todo: todo, index: todoIndex);
          },
        ),
      ),
    );
  }

  void showChangeDialog({required Todo todo, required BuildContext context}) {
    final TextEditingController changeTodoController = TextEditingController();

    changeTodoController.text = todo.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Todo'),
          content: TextField(
            controller: changeTodoController,
            decoration: InputDecoration(hintText: ""),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                // changeTodoController.dispose();
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('CHANGE'),
              onPressed: () {
                changeTodo(fromTodo: todo, text: changeTodoController.text);

                // changeTodoController.dispose();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
