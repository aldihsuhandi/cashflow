import 'package:cashflow/database/databasehelper.dart';
import 'package:cashflow/model/entry.dart';

class EntryController
{
    final dbHelper = DatabaseHelper.instance;

    void insert(String desc, int money, String type) async
    {
        Entry entry = Entry(desc, money, type);
        dbHelper.saveEntry(entry);
    }

    Future<List<Entry>> all() async
    {
        Future<List<Entry>> entries = dbHelper.getEntries();
        return entries;
    }
}