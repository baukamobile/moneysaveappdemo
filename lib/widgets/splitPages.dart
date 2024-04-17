import 'package:flutter/material.dart';
import 'package:moneyapp/bottombar/bottombar.dart';
import 'package:moneyapp/incomesWidgets/incomes.dart';
import 'package:moneyapp/widgets/expences.dart';

class ExpensePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Expenses Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class IncomePage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Incomes Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SplitPages extends StatefulWidget {
  
  const SplitPages({Key? key}) : super(key: key);

  @override
  _SplitPagesState createState() => _SplitPagesState();
}

class _SplitPagesState extends State<SplitPages> {
    void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe
            if (_currentPageIndex > 0) {
              _currentPageIndex--;
              _pageController.animateToPage(
                _currentPageIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          } else if (details.primaryVelocity! < 0) {
            // Swipe
            if (_currentPageIndex < 1) {
              _currentPageIndex++;
              _pageController.animateToPage(
                _currentPageIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          }
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            Expences(),
            Incomes(),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
 

void main() {
  runApp(MaterialApp(
    title: 'Split Pages Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: SplitPages(),
  ));
}
