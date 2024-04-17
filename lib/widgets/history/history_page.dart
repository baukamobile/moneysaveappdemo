import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_list.dart';


class historyPage extends StatelessWidget {
  historyPage({Key? key}) : super(key: key);
  
final List<Expense> _registeredExpences = [
    Expense(title: 'Breakfast', amount: 2000, date: DateTime.now(), category: Category.food),
    Expense(title: 'Hang out with friends', amount: 5000, date: DateTime.now(), category: Category.cafe),
    Expense(title: 'Buy course', amount: 25000, date: DateTime.now(), category: Category.study),
    Expense(title: 'Buy work things', amount: 1000, date: DateTime.now(), category: Category.work),
  ];
  void _onremove(Expense expense){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 186, 130),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text('History')),
      body: Column(
        children: [
          Expanded(child: ExpensesList(expenses: _registeredExpences, onRemove: _onremove))
        ],
      ),
    );
  }
}