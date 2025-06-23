import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';

import 'package:todo_app/widget/add_task_widget.dart';
import 'package:todo_app/widget/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ToDo List"),

            const SizedBox(width: 7.0),

            Image.asset('assets/images/todo_list_icon.png', height: 30.0),
          ],
        ),
      ),

      body: Consumer<TodoProvider>(
        builder:
            (BuildContext context, TodoProvider todoProvider, Widget? child) {
              return Column(children: [AddTaskWidget(todoProvider: todoProvider), TodoList(todoProvider: todoProvider,)]);
            },
      ),
    );
  }
}
