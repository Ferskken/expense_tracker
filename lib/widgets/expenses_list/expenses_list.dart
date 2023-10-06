import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// A custom widget for displaying a list of expenses
class ExpensesList extends StatelessWidget {
  // Constructs an [ExpensesList] widget.
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  // Callback function to remove an expense
  final void Function(Expense expense) onRemoveExpense;

  // List of expenses to be displayed
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // Create a ListView.builder to efficiently build a list of expense items
    return ListView.builder(
      itemCount: expenses.length, // Set the number of items in the list
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]), // Unique key for each item
        background: Container(
            // Background color when swiping to delete
            color: Theme.of(context).colorScheme.error.withOpacity(0.50),
            margin: EdgeInsets.symmetric(
              // Set horizontal margin to match card theme
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            )),
        onDismissed: (direction) {
          // Handle the dismissal action (e.g., delete expense)
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
