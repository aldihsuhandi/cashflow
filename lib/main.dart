import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cashflow/view/mainview.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        backgroundColor: HexColor('#7aa6ed'),
        primaryColor: HexColor('#eceff4'),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color(0xff2e3440)),
        ),
      ),
      home: const MainView(),
    ),
  );
}
