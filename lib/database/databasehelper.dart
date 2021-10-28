import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
        return _database ??= await _initDatabase();
        // if(_database == null)
        // {
        //     _database = await _initDatabase();
        // }

        // return _database;
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
            CREATE TABLE row_types {
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL
            };
        ''');

        await db.execute('''
            INSERT INTO row_types(name)
            VALUES('Credit'), ('Debit');
        ''');

        await db.execute('''
            CREATE TABLE rows {
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                description TEXT NOT NULL,
                money INTEGER NOT NULL,
                type_id INTEGER NOT NULL,
                FOREIGN KEY(type_id) REFERENCES row_types(id)
            };
        ''');

    }
}