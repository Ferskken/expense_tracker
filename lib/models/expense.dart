class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.id,
      required this.date});

  final String title;
  final double amount;
  final String id;
  final DateTime date;
}
