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
              int id = snapshot.data![i].id;
              String description = snapshot.data![i].description;
              int money = snapshot.data![i].money;
              String type = snapshot.data![i].type;
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
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(10),
                    //   topRight: Radius.circular(10),
                    //   bottomLeft: Radius.circular(10),
                    //   bottomRight: Radius.circular(10),
                    // ),
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3)),
                    ],
                  ),
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
                          Text("Rp." + money.toString()),
                        ]),
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
