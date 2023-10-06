import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// A custom widget for displaying an individual expense item
class ExpenseItem extends StatelessWidget {
  // Constructs an [ExpenseItem] widget.
  const ExpenseItem(this.expense, {super.key});

  // The expense to be displayed in the item
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Create a card to display the expense item
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the title of the expense
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              // Display the formatted amount of the expense
              Text("\$${expense.amount.toStringAsFixed(2)}"),
              const Spacer(), // Add spacing to push the following items to the right
              Row(
                children: [
                  // Display an icon associated with the expense category
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8), // Add a small horizontal spacing
                  // Display the formatted date of the expense
                  Text(expense.formattedDate)
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
