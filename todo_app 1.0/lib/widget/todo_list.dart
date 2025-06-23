import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/todo_provider.dart';

import 'package:todo_app/widget/todo_widget.dart';


class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todoProvider});

  final TodoProvider todoProvider;

  @override
  State<TodoList> createState() => _TaskListState();
}

class _TaskListState extends State<TodoList> {


  @override
  Widget build(BuildContext context) {
    final List<Todo> todoList = widget.todoProvider.todoList;
    return Expanded(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoWidget(todo: todoList[index], todoProvider: widget.todoProvider,);
        },
      ),
    );
  }
}
