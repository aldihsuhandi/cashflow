import 'package:cashflow/view/add.dart';
import 'package:cashflow/view/summary.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    HomePage(key: UniqueKey()),
    SummaryView()
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  onGoBack(dynamic value) {
    setState(() {
      _widgetOptions[0] = HomePage(key: UniqueKey());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddView()))
                .then(onGoBack);
          },
          tooltip: 'Add new',
          child: const Icon(Icons.add),
          elevation: 2.0),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xff7aa6ed),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onTapped,
      ),
    );
  }
}
