import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cashflow/model/entry.dart';

class DatabaseHelper {
  static const _databaseName = "cash_flow.db";
  static const _databaseVersion = 1;

  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;
  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE entries (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT NOT NULL,
          money INTEGER NOT NULL,
          type TEXT NOT NULL,
          date TEXT NOT NULL
        )''');
  }

  // Helper methods
  void saveEntry(Entry entry) async {
    String entryDesc = entry.description;
    int entryMoney = entry.money;
    String entryType = entry.type;
    String entryDate = entry.date.toString();
    var dbInstance = await database;
    await dbInstance.transaction((txn) async {
      return await txn.rawInsert('''
          INSERT INTO entries(description, money, type, date)
          VALUES ('$entryDesc', '$entryMoney', '$entryType', '$entryDate')
        ''');
    });
  }

  Future<List<Entry>> getEntries() async {
    var dbInstance = await database;

    final List<Map<String, dynamic>> maps = await dbInstance.query('entries');
    return List.generate(maps.length, (i) {
      return Entry(
          id: maps[i]['id'],
          description: maps[i]['description'],
          money: maps[i]['money'],
          type: maps[i]['type'],
          date: DateTime.parse(maps[i]['date']));
    });
  }

  Future<void> updateEntry(Entry entry) async {
    var dbInstance = await database;

    await dbInstance.update('entries', entry.toMap(),
        where: 'id = ?', whereArgs: [entry.id]);
  }

  Future<void> deleteEntry(int id) async {
    var dbInstance = await database;
    await dbInstance.delete('entries', where: 'id = ?', whereArgs: [id]);
  }
}
