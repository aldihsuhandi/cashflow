class Row 
{
    late String desc;
    late int money;
    late String type;

    Row(this.desc, this.money, this.type);

    Row.fromMap(Map map)
    {
        desc = map[desc];
        money = map[money];
        type = map[type];
    }
}