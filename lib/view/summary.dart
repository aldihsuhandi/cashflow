import 'dart:collection';

import 'package:cashflow/view/widget/summarylist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cashflow/model/entry.dart';

import 'package:cashflow/controller/entrycontroller.dart';

class SummaryView extends StatelessWidget {
  SummaryView({Key? key}) : super(key: key);

  final EntryController _ec = EntryController();
  final dateFormat = DateFormat("dd MMMM yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          "Summary",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: FutureBuilder<List<Entry>>(
        future: _ec.getEntry(),
        builder: (context, AsyncSnapshot<List<Entry>> snapshot) {
          if (snapshot.hasData) {
            LinkedHashMap<List<String>, int> mapEntry = LinkedHashMap();
            for (int i = 0; i < snapshot.data!.length; ++i) {
              Entry entry = snapshot.data![i];
              String month =
                  DateFormat.MMMM().format(DateTime(0, entry.date.month));
              String year = entry.date.year.toString();
              int money = entry.money;

              if (mapEntry[[month, year]] == null) {
                mapEntry[[month, year]] = money;
              } else {
                mapEntry[[month, year]] = mapEntry[[month, year]]! + money;
              }
            }

            return SummaryList(mapEntry);
          } else {
            return const Text("Null");
          }
        },
      ),
    );
  }
}
