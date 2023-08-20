import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.newExpense});

  final void Function(ExpenseModel expenselist) newExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //there are two approaches of saving the input text of the textfield

  // 1
  // String _newText = "";
  //
  // void _saveText (String enteredText)
  // {
  //   _newText = enteredText;
  // }

  // 2
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _returnDate;

  Category _returnCategory = Category.food;

  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final present = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _returnDate = present;
    });
  }

  void _showDialog() {
    if( Platform.isIOS) {
      showCupertinoDialog(context: context, builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Invalid Input'),
        content: const Text(
            ' Please make sure that the entered title, amount or date is valid '),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'))
        ],
      ),
      );
    }
    else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              ' Please make sure that the entered title, amount or date is valid '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }
  }

  void _savingData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //here trim removes all the whitespaces from the string

    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _returnDate == null) {


      _showDialog();
      return;
    }

    widget.newExpense(ExpenseModel(
        amount: enteredAmount!,
        date: _returnDate!,
        title: _titleController.text,
        type: _returnCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    // we used layout builder as an alternate of MediaQuery
    // to find out the width and height of the modal bottom sheet

    return LayoutBuilder(builder: (ctx,constraints) {
      // print(constraints.minHeight);
      // print(constraints.maxHeight);
      // print(constraints.minWidth);
      // print(constraints.maxWidth);

      final width = constraints.maxWidth;


      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30,keyboard + 30),
            child: Column(
              children: [
                if( width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Expanded(
                      child: TextField(
                        //2
                        controller: _titleController,

                        //onChanged: // 1  _saveText,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '₹',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                  ],)
                else
                TextField(
                  //2
                  controller: _titleController,

                  //onChanged: // 1  _saveText,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                if( width >= 600)
                  Row(children: [
                    DropdownButton(
                        value: _returnCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _returnCategory = value;
                          });
                        }),

                    const Spacer(),

                    Text(_returnDate == null
                        ? 'Select Date'
                        : formatter.format(_returnDate!)),
                    // here we have used to tell flutter that we are sure about
                    // returnDate being non-null
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined))




                  ],)
                else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '₹',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_returnDate == null
                              ? 'Select Date'
                              : formatter.format(_returnDate!)),
                          // here we have used to tell flutter that we are sure about
                          // returnDate being non-null
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month_outlined))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                if(width >= 600)
                  Row(children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //we'll learn more about it in the near future to
                          // switch between the screens
                        },
                        child: const Text('Cancel')),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _savingData, child: const Text('Save response'))
                  ],)
                else
                Row(
                  children: [
                    DropdownButton(
                        value: _returnCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _returnCategory = value;
                          });
                        }),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //we'll learn more about it in the near future to
                          // switch between the screens
                        },
                        child: const Text('Cancel')),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _savingData, child: const Text('Save response'))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });


  }
}
