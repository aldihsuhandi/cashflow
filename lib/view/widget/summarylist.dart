import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cashflow/model/entry.dart';

import 'package:cashflow/controller/entrycontroller.dart';

class SummaryList extends StatefulWidget {
  final Map<List<String>, int> mapEntry;

  // ignore: use_key_in_widget_constructors
  const SummaryList(this.mapEntry);

  @override
  State<StatefulWidget> createState() {
    return _SummaryList();
  }
}

class _SummaryList extends State<SummaryList> {
  List<String> years = [];
  String year = "All";

  @override
  void initState() {
    widget.mapEntry.forEach((key, value) {
      years.add(key[1].toString());
    });

    years = years.toSet().toList();
    years.insert(0, "All");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DropdownButton<String>(
          value: year,
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
      ],
    );
  }
}
