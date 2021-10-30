import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cashflow/view/home.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        backgroundColor: HexColor('#7aa6ed'),
        primaryColor: HexColor('#eceff4'),
      ),
      home: HomePage(),
    ),
  );
}
