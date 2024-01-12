import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqf_lite/repositories/database_connection.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static late Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, data) async {
    final connection = await database;
    return await connection.insert(table, data);
  }
}