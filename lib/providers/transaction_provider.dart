import 'package:flutter/material.dart';
import 'package:gelir_gider/fake/fake_transactions.dart';
import 'package:gelir_gider/models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  DateTime selectedMonth = DateTime(2026, 1);

  final List<TransactionModel> _allTransactions = fakeTransactions;

  List<TransactionModel> get filteredTransaction {
    return _allTransactions.where((t) {
      return t.date.year == selectedMonth.year &&
          t.date.month == selectedMonth.month;
    }).toList();
  }

  List<TransactionModel> get recentTransactions {
    final sorted = [...filteredTransaction]
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(5).toList();
  }

  double get totalIncome {
    return filteredTransaction
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return filteredTransaction
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get netTotal => totalIncome - totalExpense;

  String get selectedMonthLabel {
    const month = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return "${month[selectedMonth.month - 1]} ${selectedMonth.year}";
  }

  void setSelectedMonth(int year, int month) {
    selectedMonth = DateTime(year, month);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _allTransactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void updateTransaction(String id, TransactionModel transaction) {
    var changeTransactionIndex = _allTransactions.indexWhere((t) => t.id == id);

    if (changeTransactionIndex == -1) return; // bulunamadı

    _allTransactions[changeTransactionIndex] = transaction;
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    _allTransactions.add(transaction);

    notifyListeners();
  }
}
