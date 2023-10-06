import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/services.dart';

// A StatefulWidget for adding a new expense
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  // Callback function to add a new expense
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  // Function to present the date picker
  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  // Function to submit expense data
  void _submitExpenseData() {
    // Parse the entered amount, allowing both comma and dot as decimal separators
    final enteredAmount =
        double.tryParse(_amountController.text.replaceAll(',', '.'));

    List<String> errorMessages = [];

    if (_titleController.text.trim().isEmpty) {
      errorMessages.add("Title is missing.");
    }
    if (enteredAmount == null || enteredAmount <= 0) {
      errorMessages.add("Amount is invalid.");
    }
    if (_selectedDate == null) {
      errorMessages.add("Date is missing.");
    }

    if (errorMessages.isNotEmpty) {
      // Display an error dialog with the collected error messages
      _showErrorDialog(errorMessages.join("\n"));
    } else {
      // Create a new Expense object and add it using the callback function
      widget.onAddExpense(Expense(
          title: _titleController.text,
          amount: enteredAmount ?? 0.0,
          date: _selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context); // Close the new expense overlay
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: const Text("Invalid Input"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(cxt);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          TextField(
            // Text field for entering the expense title
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // Text field for entering the expense amount
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // Regular expression to allow numeric input with comma or dot
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*[\.,]?\d*$')),
                  ],
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? "No Date Selected"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                        ),
                      ),
                    ],
                  ),
                  // Button to use current date as [_selectedDate]
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime.now();
                      });
                    },
                    child: const Text("Use current date"),
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // Dropdown button for selecting the expense category
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              // Button to save the expense data
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("Save"),
              ),
              // Button to cancel and close the new expense overlay
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
