import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/local/todo_dao.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/model/repositories/todo_repository.dart';

class TodoListState {
  final List<Todo> todoList;
  final bool isLoading;

  const TodoListState({required this.todoList, required this.isLoading});
}

class TodoListViewModelNotifier extends StateNotifier<TodoListState> {
  final TodoRepository repo;
  TodoListViewModelNotifier({required this.repo})
    : super(TodoListState(todoList: [], isLoading: true)) {
    if (state.todoList.isEmpty) {
      _loadItems();
    }
  }

  void _loadItems() async {
    state = TodoListState(todoList: await repo.loadItems(), isLoading: false);
  }

  void addTodo(String text) {
    final Todo newTodo = Todo(text: text);

    state = TodoListState(
      todoList: [...state.todoList, newTodo],
      isLoading: false,
    );

    repo.addTodo(newTodo);
  }

  void deleteTodo(Todo todo) async {
    final List<Todo> newTodoList = List.from(state.todoList);

    newTodoList.remove(todo);

    state = TodoListState(todoList: newTodoList, isLoading: false);

    // After deleting user can undo during 2 seconds
    // that's why deleting from db calleed after 3 seconds
    await Future.delayed(Duration(seconds: 3), () {
      if (!state.todoList.contains(todo)) {
        repo.deleteTodo(todo);
      }
    });
  }

  void updateTodo({required Todo oldTodo, String? text, bool? isDone}) {
    final Todo newTodo = Todo(
      text: text ?? oldTodo.text,
      isDone: isDone ?? oldTodo.isDone,
      createdAt: oldTodo.createdAt,
      id: oldTodo.id,
    );

    final List<Todo> newTodoList = List.from(state.todoList);

    newTodoList[newTodoList.indexOf(oldTodo)] = newTodo;

    state = TodoListState(todoList: newTodoList, isLoading: false);

    repo.updateTodo(oldTodo, newTodo);
  }

  void insertTodo({required int index, required Todo todo}) {
    final newTodoList = List.of(state.todoList);

    newTodoList.insert(index, todo);

    state = TodoListState(todoList: newTodoList, isLoading: false);
  }
}

final todoViewModelProvider =
    StateNotifierProvider<TodoListViewModelNotifier, TodoListState>(
      (ref) => TodoListViewModelNotifier(repo: TodoRepository(dao: TodoDao())),
    );
