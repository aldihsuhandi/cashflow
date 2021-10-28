import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cashflow/view/header.dart';

class HomePage extends StatelessWidget
{
    Widget build(BuildContext context)
    {
        return Scaffold(
            // backgroundColor: context.backgroundColor,
            appBar: TopBar("Home"),
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                    print("This is a test button");
                },
                child: const Icon(Icons.add_circle)
            ),
        );
    }
}