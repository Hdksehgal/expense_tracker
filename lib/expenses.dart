

import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/expense_view/expense_list.dart';
import 'package:expense_tracker/expense_view/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _privateExpenses = [
    ExpenseModel(
        amount: 240.977,
        date: DateTime.now(),
        title: 'Movie',
        type: Category.leisure),
    ExpenseModel(
        amount: 120,
        date: DateTime.now(),
        title: "Chow Chow",
        type: Category.food)
  ];

  void _openAddModalOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              newExpense: addExpense,
            ));
    // context is a metadata collection managed  by the flutter
    // that belongs to a specific widget that contains
    // metadata information related to the widget and
    // information related to the widget's position in the
    // overall UI in the widget tree
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      _privateExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    var mainindex = _privateExpenses.indexOf(expense);

    setState(() {
      _privateExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expense Removed'),
      duration: Duration(seconds: 4),
      action: SnackBarAction(label: 'Undo', onPressed: () {
        setState(() {
          _privateExpenses.insert(mainindex, expense);
        });
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
   final width = MediaQuery.of(context).size.width;
   // print(MediaQuery.of(context).size.height);

    Widget MainContent =
        const Center(child: Text(' No Expenses , Start adding some! '));

    if (_privateExpenses.isNotEmpty) {
      MainContent = Expanded(
          child: ExpenseList(
        delExpense: removeExpense,
        expenseList: _privateExpenses,
      ));
    }

    return Scaffold(
        //backgroundColor: Color(0xffb8bdf2),
        appBar: AppBar(
          title: Text('Expense tracker'),
          actions: [
            IconButton(
                onPressed: _openAddModalOverlay,
                icon: const Icon(Icons.add_sharp))
          ],
        ),
        body: // because of the presence of the width:double.infinity in chart widget
        // it is showing blank screen so to fix that we have to wrap Row widget 
        // below with Expanded
        
        width < 600 ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chart(expenses: _privateExpenses),
              const SizedBox(
                height: 10,
              ),
              MainContent,
            ],
          ),
        )

      : Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Expanded(child: Chart(expenses: _privateExpenses)),
           const SizedBox(
             height: 10,
           ),
            Expanded(child: MainContent),
         ],
    )
    );
  }
}
