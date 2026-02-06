import 'package:gelir_gider/models/transaction_model.dart';

List<TransactionModel> filterByMonth(
  List<TransactionModel> allTransactions,
  DateTime selectedDate,
) {
  final filtered = allTransactions.where(
    (t) =>
        t.date.year == selectedDate.year && t.date.month == selectedDate.month,
  );
  return filtered.toList();
}

double calculateTotalExpense(List<TransactionModel> allTransactions) {
  double totalExpense = allTransactions
      .where((t) => !t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);
  return totalExpense;
}

double calculateTotalIncome(List<TransactionModel> allTransactions) {
  double totalIncome = allTransactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);
  return totalIncome;
}
