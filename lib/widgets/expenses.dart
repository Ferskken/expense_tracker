import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'chart/chart.dart';

// A StatefulWidget that represents the main expenses page
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    //Left dummy Expenses in for ease of testing.
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

  // Function to open the "Add Expense" overlay
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // Function to add an expense to the list
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Function to remove an expense from the list
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Expense deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize main content as a message if there are no expenses
    Widget mainContent = const Center(child: Text("No expenses in list"));

    // If there are registered expenses, display the ExpensesList widget
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child:
                mainContent, // Display either the message or the list of expenses
          ),
        ],
      ),
    );
  }
}
