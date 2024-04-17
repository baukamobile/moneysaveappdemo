import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneyapp/bottombar/bottombar.dart';
import 'package:moneyapp/widgets/NewAddWindow.dart';
import 'package:moneyapp/widgets/elements/drawer.dart';
import 'package:moneyapp/widgets/expenses_list/chart.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_list.dart';
import 'package:moneyapp/models/expence.dart';
import 'package:mrx_charts/mrx_charts.dart';

class Incomes extends StatefulWidget {
  const Incomes({Key? key}) : super(key: key);

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> {
  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpences.remove(expense);
      expenseTracker-=expense.amount;

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
  expenseTracker+=expense.amount;
  // Navigator.pop(context);
  });
}

double expenseTracker = 10000.0;
void _updateExpenseTracker(double newValue) {
    setState(() {
      expenseTracker = newValue;
    });
  }
  
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
          }, icon: Icon(Icons.add_card)),
              IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    double newExpenseValue = expenseTracker;
                    return AlertDialog(
                      title: Text('Update Expense Tracker'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          newExpenseValue = double.tryParse(value) ?? expenseTracker;
                        },
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _updateExpenseTracker(newExpenseValue);
                            Navigator.pop(context);
                          },
                          child: Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.edit),
            ),
        
        ]),
        body: Column(
          
          children: [
  Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 90),
              child: Row(
                children: [
                  Text("Incomes to: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text("\$$expenseTracker", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          


            Expanded(
              flex: 1,
              child: Chart(
              layers: [
                ChartAxisLayer(
                  settings: ChartAxisSettings(
                    x: ChartAxisSettingsAxis(
              frequency: 1.0,
              max: 13.0,
              min: 7.0,
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 10.0,
                ),
              ),
              y: ChartAxisSettingsAxis(
                frequency: 100.0,
                max: 300.0,
                min: 0.0,
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10.0,
                ),
              ),
                    ),
                    labelX: (value) => value.toInt().toString(),
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: List.generate(
              13 - 7 + 1,
              (index) => ChartBarDataItem(
                color: const Color.fromARGB(255, 71, 186, 130),
                value: Random().nextInt(280) + 20,
                x: index.toDouble() + 7,
              ),
                    ),
                    settings: const ChartBarSettings(
              thickness: 8.0,
              radius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                
              ]
            ),
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