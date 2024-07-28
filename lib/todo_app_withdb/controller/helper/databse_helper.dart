import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'todo.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY AUTOINCREMENT, task_name TEXT NOT NULL, is_done INTEGER NOT NULL, note TEXT, priority INTEGER NOT NULL)');
      },
    );
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    await db!.insert('Task', task);
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await database;
    return await db!.query('Task');
  }

  Future<void> updateTask(int id, Map<String, dynamic> task) async {
    final db = await database;
    await db!.update('Task', task, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db!.delete('Task', where: 'id = ?', whereArgs: [id]);
  }
}
