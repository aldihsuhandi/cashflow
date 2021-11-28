import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cashflow/model/entry.dart';

class SummaryList extends StatefulWidget {
  final List<Entry> entries;

  // ignore: use_key_in_widget_constructors
  const SummaryList(this.entries);

  @override
  State<StatefulWidget> createState() {
    return _SummaryList();
  }
}

class _SummaryList extends State<SummaryList> {
  List<String> years = [];
  final SplayTreeMap<String, SplayTreeMap<String, List<int>>> mapEntry =
      SplayTreeMap();
  String year = "All";

  @override
  void initState() {
    for (int i = 0; i < widget.entries.length; ++i) {
      Entry entry = widget.entries[i];
      String year = entry.date.year.toString();
      String month = DateFormat('MMMM').format(DateTime(0, entry.date.month));
      String type = entry.type;
      int money = entry.money;
      years.add(year);

      if (mapEntry.containsKey(year) == false) {
        mapEntry[year] = SplayTreeMap();
      }

      if (mapEntry[year]!.containsKey(month) == false) {
        mapEntry[year]![month] = [0, 0];
      }

      if (type == "Pengeluaran") {
        mapEntry[year]![month]![0] += money;
      } else {
        mapEntry[year]![month]![1] += money;
      }
    }

    years = years.toSet().toList();
    years.insert(0, "All");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> summaryList = [];

    summaryList.add(
      Container(
        padding: const EdgeInsets.all(25),
        child: DropdownButton<String>(
          value: year,
          isExpanded: true,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 12,
          elevation: 16,
          style: const TextStyle(
              color: Color(0xff2e3440),
              fontSize: 12,
              fontWeight: FontWeight.normal),
          onChanged: (String? newVal) {
            setState(() {
              year = newVal!;
            });
          },
          items: years.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );

    mapEntry.forEach((key, value) {
      if (year == "All" || key == year) {
        value.forEach((month, money) {
          summaryList.add(
            Container(
              margin: const EdgeInsets.only(
                top: 4,
                left: 3,
                right: 3,
                bottom: 4,
              ),
              padding: const EdgeInsets.only(
                bottom: 7,
                left: 3,
                right: 3,
                top: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(key),
                          const SizedBox(height: 5),
                          Text(
                            month,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Rp." + money[1].toString(),
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            )),
                        const SizedBox(height: 5),
                        Text("- Rp." + money[0].toString(),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }
    });

    return Container(
        padding: const EdgeInsets.all(5),
        child: ListView(children: summaryList));
  }
}
