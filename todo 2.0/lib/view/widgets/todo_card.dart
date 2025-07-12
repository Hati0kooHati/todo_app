import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/view_model/todo.dart';

class TodoCardWidget extends ConsumerStatefulWidget {
  final TodoViewModel todoViewModel;
  final Todo todo;

  const TodoCardWidget({
    super.key,
    required this.todo,
    required this.todoViewModel,
  });

  @override
  ConsumerState<TodoCardWidget> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo),
      onDismissed: (direction) {
        widget.todoViewModel.showDeleteInfo(
          todo: widget.todo,
          context: context,
        );
        widget.todoViewModel.deleteTodo(todo: widget.todo);
      },
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              widget.todoViewModel.changeTodo(
                fromTodo: widget.todo,
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
                          widget.todoViewModel.showChangeDialog(
                            todo: widget.todo,
                            context: context,
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),

                      IconButton(
                        onPressed: () {
                          widget.todoViewModel.showDeleteInfo(
                            todo: widget.todo,
                            context: context,
                          );
                          widget.todoViewModel.deleteTodo(todo: widget.todo);
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
