import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


final formatter = DateFormat.yMd();
const uuid = Uuid();
enum Category {food,
 travel,
leisure,
work,
study,
 invest,
  shopping, 
  lending, family, cafe, 
  bus, taxi, airplane, train, 
}


const categoryIcons = {
  
  Category.food: Icons.food_bank,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.sports_soccer, 
  Category.work: Icons.work,
  Category.study: Icons.book,
  Category.invest: Icons.bar_chart,
  Category.shopping: Icons.shopping_cart,
  Category.lending: Icons.money,
  Category.family: Icons.family_restroom,
  Category.cafe: Icons.local_cafe,
  Category.bus: Icons.directions_bus,
  Category.taxi: Icons.local_taxi,
  Category.airplane: Icons.airplanemode_active,
  Category.train: Icons.train,
};
class Expense{
Expense({

  required this.title, 
  required this.amount,
  required this.date,
  required this.category
  }): id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; 

  String get FormattedDate{
    return formatter.format(date);

  }
  // String get CategoryImage{
  //   return categoryIcons[category] ?? '';
  // }
}