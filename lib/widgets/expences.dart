import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneyapp/bottombar/bottombar.dart';
import 'package:moneyapp/widgets/NewAddWindow.dart';
import 'package:moneyapp/widgets/elements/drawer.dart';
import 'package:moneyapp/widgets/expenses_list/chart.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_list.dart';
import 'package:moneyapp/models/expence.dart';



class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  
  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpences.remove(expense);
    });
  }
  void _opendNewAddExpense(){
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    // backgroundColor: Colors.black.withOpacity(0), // Adjust opacity value as needed
    builder: (ctx) {
      return NewWindow(onAddExpense: AddExpenses,); // Replace NewWindow() with your widget
    },
  );
}
void AddExpenses(Expense expense){
  setState(() {
  _registeredExpences.add(expense);
  // Navigator.pop(context);
  });
}

double expenseTracker = 10000.0;

  final List<Expense> _registeredExpences = [
    Expense(title: 'Breakfast', amount: 2000, date: DateTime.now(), category: Category.food),
    Expense(title: 'hang out with friends', amount: 5000, date: DateTime.now(), category: Category.cafe),
    Expense(title: 'buy course', amount: 25000, date: DateTime.now(), category: Category.study),
    Expense(title: 'buy work things', amount: 1000, date: DateTime.now(), category: Category.work),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          
          backgroundColor: Color.fromARGB(255, 71, 186, 130),
          title: Text('MoneySave'),
          centerTitle: true,
          actions: [
          IconButton(onPressed: (){
            _opendNewAddExpense();
            // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NewPage()));
          }, icon: Icon(Icons.add_card))
        ]),
        body: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 90),
              child: Row(
                children: [
                  Text("Expenses from: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text("\$10000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          
            Expanded(
              flex: 1,
              child: 
            MyChart()
            
            ),
            
            Expanded(
              flex: 2,
              child: ExpensesList(expenses: _registeredExpences, onRemove: _removeExpense,))
          ],
        ),
    // bottomNavigationBar: MyBottomBar(),
      ),
    );
  }
}