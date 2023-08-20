import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();

enum Category {work, food, leisure, travel}

const categoryIcons = {

  Category.work : Icons.work_outline,
  Category.travel : Icons.travel_explore,
  Category.leisure : Icons.person_outline_sharp,
  Category.food : Icons.fastfood_outlined
};

var formatter = DateFormat.yMd();

class ExpenseModel {
  ExpenseModel({
    required this.amount,
    required this.date,
    required this.title,
    required this.type
  }) : id = uuid.v4();

  final String id;
  final DateTime date;
  final double amount;
  final String title;
  final Category type;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.category,this.expenses);

  final List<ExpenseModel> expenses;
  final Category category;

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.type == category).toList();


  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses)
      {
        sum += expense.amount;
      }

    return sum;
  }
}