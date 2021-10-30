import 'package:flutter/material.dart';

import 'package:cashflow/controller/entrycontroller.dart';
import 'package:hexcolor/hexcolor.dart';

class AddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddScreen();
  }
}

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController moneyController = TextEditingController();

  List<String> types = ["Credit", "Debit"];
  String typeVal = "";
  @override
  void initState() {
    super.initState();
    typeVal = types[0];
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
              Container(
                width: 60,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffa3be8c),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 12))),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Description'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: moneyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Rp. '),
          ),
          const SizedBox(height: 12),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Type of transaction"),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: typeVal,
                // isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 12,
                elevation: 16,
                style: const TextStyle(
                  color: Color(0xff2e3440),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (String? newVal) {
                  setState(() {
                    typeVal = newVal!;
                  });
                },
                items: types.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
