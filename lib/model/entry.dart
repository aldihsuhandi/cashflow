class Entry {
  late int id;
  late String description;
  late int money;
  late String type;

  Entry(
      {required this.id,
      required this.description,
      required this.money,
      required this.type});

  Entry.fromEntry(Entry e) {
    description = e.description;
    money = e.money;
    type = e.type;
  }

  Entry.fromMap(Map map) {
    description = map[description];
    money = map[money];
    type = map[type];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descriptions': description,
      'money': money,
      'type': type,
    };
  }
}
