import 'package:flutter/material.dart';
import 'package:moneyapp/profile/ProfilePage.dart';
import 'package:moneyapp/widgets/history/history_page.dart';
import 'package:moneyapp/widgets/splitPages.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 71, 186, 130),
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => _navigateToPage(context, SplitPages()),
          ),
          IconButton(
            icon: Icon(Icons.credit_card),
            onPressed: () => _navigateToPage(context, SplitPages()),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _navigateToPage(context, historyPage()),
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => _navigateToPage(context, profilePage(name: '',)),
          ),
        ],
      ),
    );
  }
}
