import 'package:flutter/material.dart';

import 'package:cashflow/view/header.dart';
import 'package:cashflow/view/add.dart';
import 'package:cashflow/controller/entrycontroller.dart';

class HomePage extends StatelessWidget
{
    // final EntryController _ec = EntryController();

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            // backgroundColor: context.backgroundColor,
            appBar: TopBar("Home", false),
            floatingActionButton: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                    backgroundColor: Theme.of(context).backgroundColor,
                    onPressed: (){
                        Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => AddView()) 
                        );
                    },
                    child: const Icon(
                        Icons.add,
                    ),
                ),
            ),
        );
    }
}