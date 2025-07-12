import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/view/widgets/todo_add.dart';
import 'package:todo_app/view/widgets/todo_list.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  late final TodoViewModel todoViewModel;

  @override
  void initState() {
    super.initState();
    todoViewModel = TodoViewModel(ref);
  }

  @override
  Widget build(BuildContext context) {
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
          TodoAddWidget(todoViewModel: todoViewModel),
          Expanded(
            child: TodoListWidget(
              todoList: todoViewModel.todoList,
              todoViewModel: todoViewModel,
            ),
          ),
        ],
      ),
    );
  }
}
