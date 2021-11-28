// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import 'package:cashflow/controller/entrycontroller.dart';
import 'package:intl/intl.dart';

class AddView extends StatelessWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddScreen();
  }
}

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreen();
}

class _AddScreen extends State<AddScreen> {
  final EntryController _ec = EntryController();
  final dateFormat = DateFormat("dd MMMM yyyy");

  TextEditingController descriptionController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool _descriptionValid = true;
  bool _moneyValid = true;
  bool _dateValid = true;

  DateTime? date;

  List<String> types = ["Pengeluaran", "Pendapatan"];
  String typeVal = "";
  @override
  void initState() {
    super.initState();
    typeVal = types[0];
  }

  void insert(BuildContext context) {
    bool isFinish = true;
    setState(() {
      _descriptionValid = true;
      _moneyValid = true;
      _dateValid = true;
      if (descriptionController.text.isEmpty) {
        isFinish = false;
        _descriptionValid = false;
      }

      if (moneyController.text.isEmpty) {
        isFinish = false;
        _moneyValid = false;
      }

      if (dateController.text.isEmpty) {
        isFinish = false;
        _dateValid = false;
      }
    });

    if (isFinish == false) {
      return;
    }

    _ec.insert(descriptionController.text, int.parse(moneyController.text),
        typeVal, date!);
  }

  _selectDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDate != null && newDate != date) {
      setState(() {
        date = newDate;
        dateController.text = dateFormat.format(date!).toString();
      });
    }
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
                      insert(context);
                    },
                    child: const Text("Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 10))),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Description',
              errorText: _descriptionValid == true
                  ? null
                  : "Description Can't Be Empty",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: moneyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Rp. ',
              errorText: _moneyValid == true ? null : "Money Can't Be Empty",
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Date',
              errorText: _dateValid == true ? null : "Date Can't Be Empty",
            ),
            onTap: () {
              Future.delayed(Duration.zero, () async {
                _selectDate(context);
              });
            },
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
