// ignore_for_file: public_member_api_docs, sort_constructors_first
enum TransactionType { income, expense }

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final int amount;
  final DateTime date;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
  });

  bool get isIncome => type == TransactionType.income;
}
