import 'package:flutter/material.dart';

import 'package:cashflow/controller/entrycontroller.dart';

class AddView extends StatelessWidget
{
  TextEditingController descriptionController = TextEditingController();
  TextEditingController moneyController = TextEditingController();

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
                style: TextStyle(
                  fontSize: 14
                ),
              ),
              Container(
                width: 60,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  ),
                  color: Color(0xffa3be8c),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    )
                  )
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description'
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: moneyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rp. '
              ),
            )
          ]
        ),
      ),
    );
  }
}