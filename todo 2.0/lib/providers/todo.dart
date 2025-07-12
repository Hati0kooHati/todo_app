import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/todo.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  print(dbPath);

  final db = await sql.openDatabase(
    join(dbPath, "todo_list.db"),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE todo_list(id TEXT PRIMARY KEY, text TEXT, isDone INTEGER, createdAt TEXT)",
      );
    },
    version: 1,
  );

  return db;
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void loadItems() async {
    final db = await getDatabase();

    final loadedData = await db.query("todo_list");

    final List<Todo> newState = loadedData.map((Map row) {
      return Todo(
        id: row["id"],
        text: row["text"],
        isDone: row["isDone"] == 1 ? true : false,
        createdAt: row["createdAt"],
      );
    }).toList();

    state = newState;
  }

  void addTodo({required Todo todo}) async {
    state = [todo, ...state];

    final db = await getDatabase();

    await db.insert("todo_list", {
      "id": todo.uid,
      "text": todo.text,
      "isDone": todo.isDone ? 1 : 0,
      "createdAt": todo.createdAt,
    });
  }

  void insertTodo({required Todo todo, required int index}) {
    final newState = List<Todo>.from(state);
    newState.insert(index, todo);
    state = newState;
  }

  void deleteTodo(Todo todo) {
    final newState = List<Todo>.from(state);
    newState.remove(todo);
    state = newState;
  }

  void changeTodo({required Todo todo, String? text, bool? isDone}) async {
    final int todoIndex = state.indexOf(todo);

    final newState = List<Todo>.from(state);

    newState[todoIndex].isDone = isDone ?? todo.isDone;
    newState[todoIndex].text = text ?? todo.text;

    state = newState;

    final db = await getDatabase();

    await db.update(
      "todo_list",
      {"text": text ?? todo.text, "isDone": isDone ?? todo.isDone ? 1 : 0},
      where: "id = ?",
      whereArgs: [todo.uid],
    );
  }
}

final todoProvider = StateNotifierProvider((ref) => TodoNotifier());
