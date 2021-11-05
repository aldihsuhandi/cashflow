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
          type TEXT NOT NULL
        )''');

    await db.execute('''
      INSERT INTO entries(description, money, type)
      VALUES ('Dummy Data', 10000, 'Credit'),
             ('Dummy Data', 100000, 'Debit')
    ''');
  }

  // Helper methods
  void saveEntry(Entry entry) async {
    String entryDesc = entry.description;
    int entryMoney = entry.money;
    String entryType = entry.type;
    var dbInstance = await database;
    await dbInstance.transaction((txn) async {
      return await txn.rawInsert('''
          INSERT INTO entries(description, money, type)
          VALUES ('$entryDesc', '$entryMoney', '$entryType')
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
          type: maps[i]['type']);
    });

    // List<Map> list = await dbInstance.rawQuery('SELECT * FROM entries');
    // List<Entry> entries = [];

    // for (int i = 0; i < list.length; i++) {
    //   entries.add(
    //       Entry(list[i]["description"], list[i]["money"], list[i]["type"]));
    // }

    // // ignore: avoid_print
    // print(entries);
    // return entries;
  }

  Future<void> updateEntry(Entry entry) async {
    var dbInstance = await database;

    await dbInstance
        .update('Entry', entry.toMap(), where: 'id = ?', whereArgs: [entry.id]);
  }
}
