import 'package:flutter/material.dart';
import 'package:todo_app/provider/todo_provider.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key, required this.todoProvider});

  final TodoProvider todoProvider;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final TextEditingController _todoController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _todoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12.0),
                SizedBox(
                  width: 315.0,
                  height: 50.0,
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: "Add your task",
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 116, 115, 115),
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),

                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    cursorColor: Colors.black,
                    onSubmitted: (value) {
                      widget.todoProvider.addTask(
                        todoText: _todoController.text,
                        insertIndex: 0,
                      );
                      _todoController.clear();
                    },
                  ),
                ),

                const Spacer(),

                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    widget.todoProvider.addTask(
                      todoText: _todoController.text,
                      insertIndex: 0,
                    );
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
          ),
        ),
      ],
    );
  }
}
