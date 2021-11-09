import 'package:cashflow/view/update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cashflow/view/add.dart';
import 'package:cashflow/controller/entrycontroller.dart';
import 'package:cashflow/model/entry.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final EntryController _ec = EntryController();
  final dateFormat = DateFormat("dd MMMM yyyy");

  late Widget listEntry;

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CashFlow",
                style: TextStyle(fontSize: 14),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddView()))
                      .then(onGoBack);
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Entry>>(
        future: _ec.getEntry(),
        builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> child = [];
            for (int i = 0; i < snapshot.data!.length; ++i) {
              int id = snapshot.data![i].id;
              String description = snapshot.data![i].description;
              int money = snapshot.data![i].money;
              String type = snapshot.data![i].type;
              DateTime date = snapshot.data![i].date;
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
                                  builder: (context) => UpdateView(
                                      id, description, money, type, date)))
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
                                  style:
                                      const TextStyle(color: Color(0xff2e3440)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  type,
                                  style:
                                      const TextStyle(color: Color(0xff2e3440)),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Rp." + money.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dateFormat.format(date),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
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
          } else {
            return const Text("Null");
          }
        },
      ),
    );
  }
}
