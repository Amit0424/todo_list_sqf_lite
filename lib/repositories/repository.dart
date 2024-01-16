import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqf_lite/repositories/database_connection.dart';

class Repository{
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  insertData(table, data) async {
    final connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    final connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async {
    final connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    final connection = await database;
    return await connection.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    final connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  readDataByColumnName(table, columnName, columnValue) async {
    final connection = await database;
    return await connection.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}