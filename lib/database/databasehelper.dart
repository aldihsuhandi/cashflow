import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cashflow/model/entry.dart';

class DatabaseHelper
{
    static final _databaseName = "CashFlowDB";
    static final _databaseVersion = 1;
  
    static final table = {
        "row_types",
        "row",
    };

    static final row = {
        "row_types": {
            '_id',
            'name'
        },
        "row": {
            '_id',
            'description',
            'money',
            'type_id'
        },
    };

    DatabaseHelper._privateConstructor();
    static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

    static late Database _database;
    Future<Database> get database async
    {
        if(_database != null)
        {
            return _database;
        }

        _database = await _initDatabase();
        return _database;

    }

    _initDatabase() async
    {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        return await openDatabase(
            path,
            version: _databaseVersion,
            onCreate: _onCreate
        );
    }

    Future _onCreate(Database db, int version) async
    {
        await db.execute('''
            CREATE TABLE entries {
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                description TEXT NOT NULL,
                money INTEGER NOT NULL,
                type TEXT NOT NULL,
            };
        ''');
    }

    // Helper methods
    void saveEntry(Entry entry) async
    {
        String entryDesc = entry.desc;
        int entryMoney = entry.money;
        String entryType = entry.type;
        var dbInstance = await database;
        await dbInstance.transaction((txn) async {
            return await txn.rawInsert('''
                INSERT entries(description, money, type)
                VALUES ($entryDesc, $entryMoney, $entryType)
            ''');
        });
    }

    Future<List<Entry>> getEntries() async
    {
        var dbInstance = await database;
        List<Map> list = await dbInstance.rawQuery('SELECT * FROM entries');
        List<Entry> entries = [];

        for(int i = 0;i < list.length; i++){
            entries.add(Entry(list[i]["description"], list[i]["money"], list[i]["type"]));
        }

        // ignore: avoid_print
        print(entries.length);
        return entries;
    }
}