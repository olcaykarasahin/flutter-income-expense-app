import 'package:gelir_gider/models/transaction_model.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';

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

List<TransactionModel> filterByYear(
  List<TransactionModel> allTransaction,
  DateTime selectedDate,
) {
  final filtered = allTransaction.where(
    (t) => t.date.year == selectedDate.year,
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

Map<String, double> calculateCategoryTotals(
  List<TransactionModel> transactions,
  ChartType selectedType,
) {
  final Map<String, double> categoryTotals = {};

  for (final tx in transactions) {
    if (selectedType == ChartType.expense &&
        tx.type != TransactionType.expense) {
      continue;
    }

    if (selectedType == ChartType.income && tx.type != TransactionType.income) {
      continue;
    }

    if (categoryTotals.containsKey(tx.category)) {
      categoryTotals[tx.category] = categoryTotals[tx.category]! + tx.amount;
    } else {
      categoryTotals[tx.category] = tx.amount;
    }
  }

  final sortedEntries = categoryTotals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Map.fromEntries(sortedEntries);
}

double calculateGrandTotal(Map<String, double> categoryTotals) {
  double total = 0;

  for (final value in categoryTotals.values) {
    total += value;
  }

  return total;
}

double calculatePercentage(double amount, double grandTotal) {
  if (grandTotal == 0) return 0;

  return (amount / grandTotal) * 100;
}
