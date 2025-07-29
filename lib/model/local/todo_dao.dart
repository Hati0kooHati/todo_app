import 'package:todo_app/model/local/local_database.dart';

class TodoDao {
  void addTodo(Map<String, dynamic> todoMap) async {
    final db = await LocalDatabase.db;
    db.insert("todo_list", todoMap);
  }

  void deleteTodo(String id) async {
    final db = await LocalDatabase.db;

    db.delete("todo_list", where: "id = ?", whereArgs: [id]);
  }

  void updateTodo(String id, Map<String, dynamic> newTodoMap) async {
    final db = await LocalDatabase.db;

    db.update("todo_list", newTodoMap, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> loadItems() async {
    final db = await LocalDatabase.db;

    return await db.query("todo_list");
  }
}
