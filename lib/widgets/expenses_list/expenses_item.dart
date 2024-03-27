import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';

class ExpenseItem extends StatelessWidget {

  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(height: 4,),
            Row(
              children: [
                Text('\₸${' '+expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category], size: 50,),
                    // Image.asset(CategoryImage(),width: 300,height: 200,),
                // SizedBox(width: 10,),

                Text(expense.FormattedDate),
                  ],
                ),
                // Icon(Icons.abc),
              ],
            )
          ],
        ),
      ),
    );
  }
}