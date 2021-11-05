// ignore_for_file: avoid_print

import 'package:cashflow/database/databasehelper.dart';
import 'package:cashflow/model/entry.dart';

class EntryController {
  final dbHelper = DatabaseHelper.instance;
  void insert(String description, int money, String type) async {
    print(description);
    print(money);
    print(type);
    Entry entry =
        Entry(id: 0, description: description, money: money, type: type);
    dbHelper.saveEntry(entry);
  }

  Future<List<Entry>> getEntry() async {
    List<Entry> entries = await dbHelper.getEntries();
    dbHelper.getEntries().then((value) => {entries = value});
    for (int i = 0; i < entries.length; i++) {
      print(entries[i].id);
      print(entries[i].description);
      print(entries[i].type);
      print(entries[i].money);
    }
    return entries;
  }

  void update(int id, String description, int money, String type) {
    Entry entry =
        Entry(id: id, description: description, money: money, type: type);
    dbHelper.updateEntry(entry);
  }

  void delete(int id) {
    dbHelper.deleteEntry(id);
  }
}
