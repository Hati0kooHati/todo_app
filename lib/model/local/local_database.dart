import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class LocalDatabase {
  LocalDatabase._();

  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    return await _initDb();
  }

  static Future<Database> _initDb() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      join(dbPath, "todo_list.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todo_list(id TEXT PRIMARY KEY, text TEXT, isDone INTEGER, createdAt TEXT)",
        );
      },
      version: 1,
    );
  }
}
