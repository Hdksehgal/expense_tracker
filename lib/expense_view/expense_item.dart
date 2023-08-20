import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({super.key,required this.expenseList });

  final ExpenseModel expenseList;


  @override
  Widget build(BuildContext context) {
    return Card(
      // Card is a widget to style a card-like conatiner
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenseList.title, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 30,),
            Row(
              children: [
                Text('\$${expenseList.amount.toStringAsFixed(2)}'),
                // here tostringasfixed is used so that only 2
                // fractions atmost is written in string after decimal
                // we have '\' to consider the special character written ahead
                // of '\' as a string character

                const Spacer(),
                //spacer is used to occupy all the spacing left
                // between the Text and Row widget

                Row(
                  children: [
                    Icon(categoryIcons[expenseList.type]),

                    SizedBox(width: 10,),

                    Text(expenseList.formattedDate),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}