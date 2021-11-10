import 'package:cashflow/view/summary.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: const Image(
                image: AssetImage('assets/logo/LOGO.png'),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            ListTile(
              title: const Text("Summary"),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SummaryView()))
              },
            ),
          ]),
        ));
  }
}
