import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';
import 'package:moneyapp/widgets/NewAddWindow.dart';
import 'package:moneyapp/widgets/elements/drawer.dart';
import 'package:moneyapp/widgets/expenses_list/chart.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_list.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key}) : super(key: key);

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  double expenseTracker = 10000.0;

  final List<Expense> _registeredExpences = [
    Expense(title: 'Breakfast', amount: 2000, date: DateTime.now(), category: Category.food),
    Expense(title: 'Hang out with friends', amount: 5000, date: DateTime.now(), category: Category.cafe),
    Expense(title: 'Buy course', amount: 25000, date: DateTime.now(), category: Category.study),
    Expense(title: 'Buy work things', amount: 1000, date: DateTime.now(), category: Category.work),
  ];

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpences.remove(expense);
      expenseTracker+=expense.amount;
    });
  }

  void _openNewAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewWindow(onAddExpense: _addExpense);
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpences.add(expense);
      expenseTracker -= expense.amount;

    });
  }
  // void _removeExpenses(Expense expense){
  //   setState(() {
  //     _registeredExpences.remove(expense);
  //     expenseTracker+=expense.amount
  //   });
  // }

  void _updateExpenseTracker(double newValue) {
    setState(() {
      expenseTracker = newValue;
    });
  }

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
            IconButton(
              onPressed: _openNewAddExpense,
              icon: Icon(Icons.add_card),
            ),
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
        
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 80),
              child: Row(
                children: [
                  Text("Expenses from: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("\$$expenseTracker", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: MyChart(),
            ),
            Expanded(
              flex: 2,
              child: ExpensesList(expenses: _registeredExpences, onRemove: _removeExpense),
            ),
          ],
        ),
      ),
    );
  }
}

