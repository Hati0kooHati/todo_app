import 'package:flutter/material.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoAddWidget extends StatefulWidget {
  final TodoViewModel todoViewModel;

  const TodoAddWidget({super.key, required this.todoViewModel});

  @override
  State<TodoAddWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<TodoAddWidget> {
  late final TextEditingController _todoController;

  @override
  void initState() {
    super.initState();

    _todoController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _todoController.dispose();
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
              controller: _todoController,
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
                widget.todoViewModel.addTodo(text: _todoController.text);
                _todoController.clear();
              },
            ),
          ),

          const Spacer(),

          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              widget.todoViewModel.addTodo(text: _todoController.text);
              FocusScope.of(context).unfocus();
              _todoController.clear();
            },
            icon: const Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 60.0,
            ),
          ),
        ],
      ),
    );
  }
}
