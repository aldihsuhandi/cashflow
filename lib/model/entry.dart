class Entry 
{
    late String desc;
    late int money;
    late String type;

    Entry(this.desc, this.money, this.type);

    Entry.fromMap(Map map)
    {
        desc = map[desc];
        money = map[money];
        type = map[type];
    }
}