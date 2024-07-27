import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Database? database;

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();

    final dbPath = join(path, 'emb.db');

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL , salary REAL NOT NULL, role TEXT)');
        });
    return database;
  }


  Future<void> insertData() async {
     await database!.rawInsert(
       'INSERT INTO Task (name, salary, role) VALUES ("AAYUSH", 100000, "Developer")');
  }


  Future<List<Map<String, Object?>>> fetchData() async {
    Database? db = await initDatabase();

    if(db != null){
      return await db.rawQuery('SELECT * FROM Task');
    }
    else{
      return [];
    }
  }

}
