import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Date formatter for formatting date strings
final formatter = DateFormat.yMd();

// Uuid generator for creating unique IDs
final uuid = Uuid();

// Enumeration for expense categories
enum Category { food, travel, leisure, work }

// Icons associated with each expense category
const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_rounded,
  Category.leisure: Icons.movie_rounded,
  Category.work: Icons.work
};

// Expense class represents an individual expense
class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); // Generate a unique ID for each expense

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  // Helper method to format the date as a string
  String get formattedDate {
    return formatter.format(date);
  }
}

// ExpenseBucket class represents a group of expenses for a specific category
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // Constructor to create an ExpenseBucket for a specific category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category; // Category associated with the bucket
  final List<Expense> expenses; // List of expenses in the bucket

  // Calculate the total expenses within the bucket
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
