import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoCardWidget extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoCardWidget({super.key, required this.todo});

  @override
  ConsumerState<TodoCardWidget> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCardWidget> {
  final TextEditingController _changeTodoController = TextEditingController();

  @override
  void dispose() {
    _changeTodoController.dispose();
    super.dispose();
  }

  void showSnackBarDeleteInfo() {
    ScaffoldMessenger.of(context).clearSnackBars();

    final Todo todo = widget.todo;
    final todoViewModelNotifier = ref.read(todoViewModelProvider.notifier);

    final int todoIndex = ref
        .read(todoViewModelProvider)
        .todoList
        .indexOf(todo);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Task has deleted"),
        action: SnackBarAction(
          label: "return",
          onPressed: () {
            todoViewModelNotifier.insertTodo(index: todoIndex, todo: todo);
          },
        ),
      ),
    );
  }

  void showChangeDialog() {
    _changeTodoController.text = widget.todo.text;
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
                ref
                    .read(todoViewModelProvider.notifier)
                    .updateTodo(
                      oldTodo: widget.todo,
                      text: _changeTodoController.text,
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
        showSnackBarDeleteInfo();
        ref.read(todoViewModelProvider.notifier).deleteTodo(widget.todo);
      },
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              ref
                  .read(todoViewModelProvider.notifier)
                  .updateTodo(
                    oldTodo: widget.todo,
                    isDone: !widget.todo.isDone,
                  );
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
                        widget.todo.text,
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
                          showChangeDialog();
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),

                      IconButton(
                        onPressed: () {
                          showSnackBarDeleteInfo();
                          ref
                              .read(todoViewModelProvider.notifier)
                              .deleteTodo(widget.todo);
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
