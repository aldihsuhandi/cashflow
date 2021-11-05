import 'package:flutter/material.dart';

import 'package:cashflow/view/add.dart';
import 'package:cashflow/controller/entrycontroller.dart';
import 'package:cashflow/model/entry.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final EntryController _ec = EntryController();

  late Widget listEntry;

  onGoBack(dynamic value) {
    print("test");
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
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddView()))
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
              String description = snapshot.data![i].description;
              int money = snapshot.data![i].money;
              String type = snapshot.data![i].type;
              child.add(Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  left: 3,
                  right: 3,
                  top: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(children: [
                  Text(description),
                ]),
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
