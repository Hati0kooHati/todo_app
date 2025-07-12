import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/view/widgets/todo_card.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todoList;
  final TodoViewModel todoViewModel;

  const TodoListWidget({
    super.key,
    required this.todoList,
    required this.todoViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,

      itemCount: todoList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return TodoCardWidget(
          todo: todoList[index],
          todoViewModel: todoViewModel,
        );
      },
    );
  }
}
