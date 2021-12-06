import 'package:cashflow/controller/entrycontroller.dart';
import 'package:cashflow/model/entry.dart';
import 'package:cashflow/view/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CardListWidget extends StatefulWidget {
  final List<Entry> entries;

  final void Function() addScreenStack;
  const CardListWidget(
      {Key? key, required this.entries, required this.addScreenStack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardListWidget();
}

class _CardListWidget extends State<CardListWidget> {
  final EntryController _ec = EntryController();
  final dateFormat = DateFormat("dd MMMM yyyy");

  onGoBack(dynamic value) {
    ;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [];
    for (int i = 0; i < widget.entries.length; ++i) {
      int id = widget.entries[i].id;
      String description = widget.entries[i].description;
      int money = widget.entries[i].money;
      String type = widget.entries[i].type;
      DateTime date = widget.entries[i].date;
      child.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          setState(() {
            _ec.delete(id);
          });
        },
        background: Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          padding: const EdgeInsets.only(
            bottom: 7,
            left: 3,
            right: 3,
            top: 7,
          ),
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(
            bottom: 7,
            left: 3,
            right: 3,
            top: 7,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateView(id, description, money, type, date)))
                  .then(onGoBack);
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(color: Color(0xff2e3440)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          type,
                          style: const TextStyle(color: Color(0xff2e3440)),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Rp." + money.toString(),
                          style: TextStyle(
                              color: type == "Pengeluaran"
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          dateFormat.format(date),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ));
    }

    return ListView(
      padding: const EdgeInsets.all(2),
      children: child,
    );
  }
}
