import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          TextField(
            controller: _valueController,
            maxLength: 50,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(prefixText: "\$ ", label: Text("Amount")),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_valueController.text);
                },
                child: const Text("Save Expense"),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_valueController.text);
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
