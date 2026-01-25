import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/category_picker.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/day_picker_inkwell.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/month_picker_inkwell.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/period_type_selector.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/transaction_summary_card.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/transaction_type_selector.dart';
import 'package:gelir_gider/screens/all_transactions_screen/widgets/year_picker_inkwell.dart';
import 'package:gelir_gider/screens/edit_screen/edit_screen.dart';
import 'package:gelir_gider/screens/home_screen/widgets/empty_transactions.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

import 'package:provider/provider.dart';

enum PeriodType { day, month, year }

enum FilterTransactionType { all, income, expense }

class AllTransactionsScreen extends StatefulWidget {
  final DateTime initialMonth;

  const AllTransactionsScreen({super.key, required this.initialMonth});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  late DateTime _selectedDate;
  PeriodType _selectedPeriodType = PeriodType.month;
  FilterTransactionType _selectedTransactionType = FilterTransactionType.all;
  String? _selectedCategory;

  Map<String, IconData> _getCategoriesForFilter() {
    switch (_selectedTransactionType) {
      case FilterTransactionType.income:
        return incomeCategoryIcons;

      case FilterTransactionType.expense:
        return expenseCategoryIcons;

      case FilterTransactionType.all:
        return {...expenseCategoryIcons, ...incomeCategoryIcons};
    }
  }

  Widget _buildCategoryPicker() {
    final categories = _getCategoriesForFilter();

    return CategoryPicker(
      categories: categories,
      selectedCategory: _selectedCategory,
      onChanged: (newCategory) {
        setState(() {
          _selectedCategory = newCategory;
        });
      },
    );
  }

  Widget _buildPeriodPicker() {
    switch (_selectedPeriodType) {
      case PeriodType.day:
        return DayPickerInkwell(
          selectedDate: _selectedDate,
          onChanged: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        );

      case PeriodType.month:
        return MonthPickerInkwell(
          selectedDate: _selectedDate,
          onChanged: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        );

      case PeriodType.year:
        return YearPickerInkwell(
          selectedDate: _selectedDate,
          onChanged: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        );
    }
  }

  List<TransactionModel> _applyFilters(List<TransactionModel> all) {
    Iterable<TransactionModel> filtered = all;
    switch (_selectedPeriodType) {
      case PeriodType.day:
        filtered = filtered.where(
          (t) =>
              t.date.year == _selectedDate.year &&
              t.date.month == _selectedDate.month &&
              t.date.day == _selectedDate.day,
        );
        break;
      case PeriodType.month:
        filtered = filtered.where(
          (t) =>
              t.date.year == _selectedDate.year &&
              t.date.month == _selectedDate.month,
        );
        break;
      case PeriodType.year:
        filtered = filtered.where((t) => t.date.year == _selectedDate.year);
        break;
    }

    switch (_selectedTransactionType) {
      case FilterTransactionType.income:
        filtered = filtered.where((t) => t.isIncome);
        break;
      case FilterTransactionType.expense:
        filtered = filtered.where((t) => !t.isIncome);
        break;
      case FilterTransactionType.all:
        break;
    }

    if (_selectedCategory != null) {
      filtered = filtered.where((t) => t.category == _selectedCategory);
    }

    return filtered.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  double getTotalIncome(List<TransactionModel> list) {
    return list.where((t) => t.isIncome).fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalExpense(List<TransactionModel> list) {
    return list.where((t) => !t.isIncome).fold(0.0, (sum, t) => sum + t.amount);
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final all = context.watch<TransactionProvider>().allTransactions;
    final transactions = _applyFilters(all);

    final income = getTotalIncome(transactions);
    final expense = getTotalExpense(transactions);

    return Scaffold(
      appBar: AppBar(title: const Text("Tüm İşlemler")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PeriodTypeSegmented(
              selected: _selectedPeriodType,
              onChanged: (type) {
                setState(() {
                  _selectedPeriodType = type;

                  if (type == PeriodType.month) {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                    );
                  } else if (type == PeriodType.year) {
                    _selectedDate = DateTime(_selectedDate.year);
                  }
                });
              },
            ),

            _buildPeriodPicker(),

            TransactionTypeSegmented(
              selected: _selectedTransactionType,
              onChanged: (type) {
                setState(() {
                  _selectedTransactionType = type;
                  _selectedCategory = null;
                });
              },
            ),

            _buildCategoryPicker(),

            const SizedBox(height: 30),

            TransactionSummaryCard(income: income, expense: expense),
            const SizedBox(height: 10),
            Expanded(child: viewList(transactions)),
          ],
        ),
      ),
    );
  }
}

Widget viewList(List<TransactionModel> filteredList) {
  return filteredList.isEmpty
      ? const Center(
          child: EmptyTransactions(message: "Seçili ay için işlem bulunmuyor."),
        )
      : ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final tx = filteredList[index];
            return Card(
              child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red.shade600,
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (direction) {
                  context.read<TransactionProvider>().deleteTransaction(tx.id);
                },
                key: ValueKey(tx.id),

                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditTransactionScreen(updatedTransactionModel: tx),
                    ),
                  ),
                  leading: Text(
                    "${tx.date.day}/"
                    "${tx.date.month}/"
                    "${tx.date.year}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Center(
                    child: Text(
                      tx.category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Center(
                    child: Text(
                      tx.comment,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: Text(
                    "₺${tx.amount}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: tx.isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
