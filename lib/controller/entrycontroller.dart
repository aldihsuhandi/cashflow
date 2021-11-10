import 'package:cashflow/database/databasehelper.dart';
import 'package:cashflow/model/entry.dart';

class EntryController {
  final dbHelper = DatabaseHelper.instance;
  void insert(String description, int money, String type, DateTime date) async {
    Entry entry = Entry(
        id: 0, description: description, money: money, type: type, date: date);
    dbHelper.saveEntry(entry);
  }

  Future<List<Entry>> getEntry() async {
    List<Entry> entries = await dbHelper.getEntries();
    dbHelper.getEntries().then((value) => {entries = value});
    return entries;
  }

  void update(
      int id, String description, int money, String type, DateTime date) {
    Entry entry = Entry(
        id: id, description: description, money: money, type: type, date: date);
    dbHelper.updateEntry(entry);
  }

  void delete(int id) {
    dbHelper.deleteEntry(id);
  }
}
