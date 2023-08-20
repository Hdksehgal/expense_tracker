import 'package:expense_tracker/expense_view/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class ExpenseList extends StatelessWidget{
  ExpenseList({super.key,required this.expenseList, required this.delExpense});

  final List<ExpenseModel> expenseList;
  final void Function(ExpenseModel expenseModel) delExpense;

  @override
  Widget build(BuildContext context) {

    //here we didn't used column because it creates many sections for column
    // at runtime which are not visible which impacts the performance
    // if we have used ListView( children : [] ) then it would have created
    // the same problem as of column but it would have been scrollable only
    return ListView.builder(itemCount: expenseList.length ,
        itemBuilder: (ctx, index) => Dismissible(key: ValueKey(expenseList[index]),
            onDismissed: (direction){
          delExpense(expenseList[index]);
        },
            child: ExpenseItem(expenseList: expenseList[index]))
    );

    // here itemcount describes the number of tiles/list item to be formed
    // and index starts from value 0
    // and executes the code only itemcount : value no. of times


  }
}