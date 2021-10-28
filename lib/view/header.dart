import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget{
  final String stringHeader;
  const TopBar(this.stringHeader); // <-- builder / constructor



  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      title: Center(
        child: Text("CashFlow | " + stringHeader)
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}