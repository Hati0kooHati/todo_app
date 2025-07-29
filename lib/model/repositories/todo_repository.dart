import 'package:todo_app/model/local/todo_dao.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utilities/map_to_todo.dart';
import 'package:todo_app/utilities/todo_to_map.dart';

class TodoRepository {
  final TodoDao dao;

  const TodoRepository({required this.dao});

  void addTodo(Todo todo) {
    dao.addTodo(todoToMap(todo));
  }

  void deleteTodo(Todo todo) {
    dao.deleteTodo(todo.id);
  }

  void updateTodo(Todo oldTodo, Todo newTodo) {
    dao.updateTodo(oldTodo.id, todoToMap(newTodo));
  }

  Future<List<Todo>> loadItems() async {
    List<Todo> transformedData = [];
    final data = await dao.loadItems();

    for (Map<String, Object?> row in data) {
      transformedData.add(mapToTodo(row));
    }

    return transformedData;
  }
}
