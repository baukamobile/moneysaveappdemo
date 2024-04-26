import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class historyPage extends StatefulWidget {
  historyPage({Key? key}) : super(key: key);

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
final List<Expense> _registeredExpences = [
    Expense(title: 'Breakfast', amount: 2000, date: DateTime.now(), category: Category.food),
    Expense(title: 'Hang out with friends', amount: 5000, date: DateTime.now(), category: Category.cafe),
    Expense(title: 'Buy course', amount: 25000, date: DateTime.now(), category: Category.study),
    Expense(title: 'Buy work things', amount: 1000, date: DateTime.now(), category: Category.work),
  ];
void _onRemove(Expense){

}
    void _addExpense(Expense expense) async {
  final url = 'http://172.20.102.202:8000/api/add_expenses/';


    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': expense.title, 
        'amount': expense.amount,
        'created_at': formatter.format(expense.date),
        'user': 10, 
        // Replace with the actual user ID or send it from your app
      }),
    );
    setState(() {
        _registeredExpences.add(expense);
        
      });
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
          Expanded(child: ExpensesList(expenses: _registeredExpences, onRemove: _onRemove))
        ],
      ),
    );
  }
}