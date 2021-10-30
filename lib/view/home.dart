import 'package:flutter/material.dart';

import 'package:cashflow/view/add.dart';
import 'package:cashflow/controller/entrycontroller.dart';

class HomePage extends StatelessWidget {
  // final EntryController _ec = EntryController();

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
      floatingActionButton: Container(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).backgroundColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddView()));
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
