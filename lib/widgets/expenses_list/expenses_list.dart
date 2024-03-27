import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';
import 'package:moneyapp/widgets/expenses_list/expenses_item.dart';


class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.onRemove});
  final void Function(Expense expense) onRemove;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction){
          onRemove(expenses[index]);
        },
        child: ExpenseItem(expenses[index])),
        
    );
  }
}