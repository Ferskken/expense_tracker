import 'package:expense_tracker/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 9.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Restourant visit",
        amount: 49.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Aquarium visit",
        amount: 29.00,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Taxi",
        amount: 7.80,
        date: DateTime.now(),
        category: Category.travel)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("The Chart"),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
