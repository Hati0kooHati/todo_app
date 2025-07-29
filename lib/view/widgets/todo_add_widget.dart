import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoAddWidget extends ConsumerStatefulWidget {
  const TodoAddWidget({super.key});

  @override
  ConsumerState<TodoAddWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends ConsumerState<TodoAddWidget> {
  late final TextEditingController _todoTextController;

  @override
  void initState() {
    super.initState();

    _todoTextController = TextEditingController();
  }

  @override
  void dispose() {
    _todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12.0),
          SizedBox(
            width: 300.0,
            child: TextField(
              controller: _todoTextController,
              decoration: const InputDecoration(
                hintText: "Add your task",
                hintStyle: TextStyle(color: Color.fromARGB(255, 116, 115, 115)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),

              style: const TextStyle(color: Colors.black, fontSize: 20.0),
              cursorColor: Colors.black,
              onSubmitted: (value) {
                ref
                    .read(todoViewModelProvider.notifier)
                    .addTodo(_todoTextController.text);
                _todoTextController.clear();
              },
            ),
          ),

          const Spacer(),

          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              ref
                  .read(todoViewModelProvider.notifier)
                  .addTodo(_todoTextController.text);
              FocusScope.of(context).unfocus();
              _todoTextController.clear();
            },
            icon: const Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
