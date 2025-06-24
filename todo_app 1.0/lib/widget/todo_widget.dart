import 'package:flutter/material.dart';

import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/todo_provider.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key, required this.todo, required this.todoProvider});

  final Todo todo;
  final TodoProvider todoProvider;

  @override
  State<TodoWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TodoWidget> {
  final TextEditingController _changeTodoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _changeTodoController.dispose();
  }

  void showBottomDeleteInfo(Todo todo) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final int todoIndex = widget.todoProvider.todoList.indexOf(todo);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task has deleted"),
        action: SnackBarAction(
          label: "return",
          onPressed: () {
            widget.todoProvider.returnTodo(todo: todo, insertIndex: todoIndex);
          },
        ),
      ),
    );
  }

  void showChangeDialog({required String todoText}) {
    _changeTodoController.text = todoText;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Todo'),
          content: TextField(
            controller: _changeTodoController,
            decoration: InputDecoration(hintText: ""),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('CHANGE'),
              onPressed: () {
                widget.todoProvider.changeTodo(
                  todo: widget.todo,
                  newTodoText: _changeTodoController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo),
      onDismissed: (direction) {
        showBottomDeleteInfo(widget.todo);
        widget.todoProvider.deleteTask(widget.todo);
      },
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              widget.todoProvider.makeTaskDone(widget.todo);
            },
            icon: Icon(
              widget.todo.isDone
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_outlined,
              color: widget.todo.isDone ? Colors.green : Colors.white,
              size: 30.0,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 65.0,
              child: Card(
                margin: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  left: 0.0,
                  right: 10.0,
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        widget.todo.todoText,
                        softWrap: true,
                        style: TextStyle(
                          decorationColor: Colors.green,
                          fontSize: 17.0,
                          color: widget.todo.isDone
                              ? Colors.green
                              : Colors.black,
                          decoration: widget.todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {
                          // function to change text called inside of showChangeDialog(), in CANCEL button
                          showChangeDialog(todoText: widget.todo.todoText);
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),

                      IconButton(
                        onPressed: () {
                          showBottomDeleteInfo(widget.todo);
                          widget.todoProvider.deleteTask(widget.todo);
                        },
                        icon: Icon(Icons.delete_outlined, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
