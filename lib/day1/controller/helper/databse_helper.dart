
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Database? database;

  Future<Database?> initDatabase() async {
  final path = await getDatabasesPath();


    return database;
  }

}