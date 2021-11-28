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
  final PageController _bodyController = PageController();

  final List<Widget> _pageOptions = [
    const HomePage(),
    SummaryView(),
    const AddView(),
  ];

  void _onTapped(int index) {
    setState(() {
      int len = _pageOptions.length - 1;
      if (index < len) {
        _selectedIndex = index;
      }
      _bodyController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _bodyController,
        children: _pageOptions,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _onTapped(2);
          },
          tooltip: 'Add new',
          child: const Icon(Icons.add),
          elevation: 2.0),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
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
