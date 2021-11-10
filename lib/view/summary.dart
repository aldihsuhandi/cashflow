import 'package:cashflow/view/widget/summarylist.dart';
import 'package:flutter/material.dart';

import 'package:cashflow/model/entry.dart';

import 'package:cashflow/controller/entrycontroller.dart';

class SummaryView extends StatelessWidget {
  SummaryView({Key? key}) : super(key: key);

  final EntryController _ec = EntryController();

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
                "Summary",
                style: TextStyle(fontSize: 14),
              ),
              Container(
                width: 60,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffa3be8c),
                ),
                child: TextButton(
                    onPressed: () {
                      _ec.export();
                    },
                    child: const Text("Export",
                        style: TextStyle(color: Colors.white, fontSize: 10))),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Entry>>(
        future: _ec.getEntry(),
        builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
          if (snapshot.hasData) {
            return SummaryList(snapshot.data!);
          } else {
            return const Text("Null");
          }
        },
      ),
    );
  }
}
