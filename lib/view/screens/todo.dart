import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/view/widgets/todo_add_widget.dart';
import 'package:todo_app/view/widgets/todo_list.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Column(
        children: [
          const TodoAddWidget(),
          ref.watch(todoViewModelProvider).isLoading
              ? const Column(
                  children: [
                    SizedBox(height: 300),
                    CircularProgressIndicator(),
                  ],
                )
              : const Expanded(child: TodoListWidget()),
        ],
      ),
    );
  }
}
