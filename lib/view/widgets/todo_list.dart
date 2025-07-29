import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/view/widgets/todo_card_widget.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todoList = ref.watch(todoViewModelProvider).todoList;
    return ListView.builder(
      shrinkWrap: true,

      itemCount: todoList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return TodoCardWidget(todo: todoList[index]);
      },
    );
  }
}
