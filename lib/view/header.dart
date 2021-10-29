import 'package:flutter/material.dart';

import 'package:cashflow/view/home.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget{
  final String stringHeader;
  final bool navButton;
  const TopBar(this.stringHeader, this.navButton); // <-- builder / constructor

  @override
  Widget build(BuildContext context)
  {
    List<Widget> widgets = [];

    widgets.add(
      Text(
        "CashFlow | " + stringHeader,
        style: const TextStyle(
          fontSize: 14
        ),
      )
    );

    if(navButton == true)
    {
      widgets.add(
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
        )
      );
    }

    return AppBar(
      title: Center(
        child: Row(
          children: widgets,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}