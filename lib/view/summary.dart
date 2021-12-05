import 'package:cashflow/view/widget/summarylist.dart';
import 'package:flutter/material.dart';

import 'package:cashflow/model/entry.dart';

import 'package:cashflow/controller/entrycontroller.dart';

class SummaryView extends StatelessWidget {
  final EntryController _ec = EntryController();

  SummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Center(
          child: Text(
            "CashFlow",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      body: FutureBuilder<List<Entry>>(
        future: _ec.getEntry(),
        builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SummaryList(snapshot.data!);
          } else {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: const Text("There is no data"),
              ),
            );
          }
        },
      ),
    );
  }
}
