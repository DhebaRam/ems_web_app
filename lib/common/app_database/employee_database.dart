import 'dart:async';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite ffi for mobile (Android/iOS)
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Private constructor
  DatabaseHelper._internal();

  // Factory to return the same instance
  factory DatabaseHelper() => _instance;

  static Database? _database;

  // Table and column names
  static const String _tableName = 'employees';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnRole = 'role';
  static const String _columnStartDate = 'start_date';
  static const String _columnEndDate = 'end_date';

  // Database initialization
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      // final databaseFactory =
      //     kIsWeb ? databaseFactoryFfiWeb : databaseFactoryFfi;

      final documentsDirectory = await getDatabasesPath();
      final path = join(documentsDirectory, 'employee_database.db');

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
            CREATE TABLE $_tableName (
              $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
              $_columnName TEXT NOT NULL,
              $_columnRole TEXT NOT NULL,
              $_columnStartDate TEXT NOT NULL,
              $_columnEndDate TEXT
            )
          ''');
          },
        ),
      );
    } catch (e) {
      print('Database Initialization Error: $e');
      rethrow; // Propagate the error for further handling.
    }
  }

  // CRUD Methods

  Future<int> addEmployee(Map<String, dynamic> employee) async {
    final db = await database;
    return await db.insert(_tableName, employee);
  }

  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    final db = await database;
    return await db.query(_tableName);
  }

  Future<int> updateEmployee(Map<String, dynamic> employee, int id) async {
    final db = await database;
    return await db.update(
      _tableName,
      employee,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
