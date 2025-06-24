import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/todo_provider.dart';

import 'package:todo_app/widget/todo_widget.dart';


class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todoProvider});

  final TodoProvider todoProvider;

  @override
  Widget build(BuildContext context) {
    final List<Todo> todoList = todoProvider.todoList;
    return Expanded(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoWidget(todo: todoList[index], todoProvider: todoProvider,);
        },
      ),
    );
  }
}
