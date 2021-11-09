class Entry {
  late int id;
  late String description;
  late int money;
  late String type;
  late DateTime date;

  Entry(
      {required this.id,
      required this.description,
      required this.money,
      required this.type,
      required this.date});

  Entry.fromEntry(Entry e) {
    description = e.description;
    money = e.money;
    type = e.type;
    date = e.date;
  }

  Entry.fromMap(Map map) {
    description = map[description];
    money = map[money];
    type = map[type];
    date = DateTime.parse(map[date]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'money': money,
      'type': type,
      'date': date.toString()
    };
  }
}
