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
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

enum PeriodType { day, month, year }

enum FilterTransactionType { all, income, expense }

class AllTransactionsScreen extends StatefulWidget {
  final DateTime initialMonth;
  final bool resetOnOpen;

  ///

  const AllTransactionsScreen({
    super.key,
    required this.initialMonth,
    required this.resetOnOpen,
  });

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  late DateTime _selectedDate;
  PeriodType _selectedPeriodType = PeriodType.month;
  FilterTransactionType _selectedTransactionType = FilterTransactionType.all;
  String? _selectedCategory;
  bool _showFilter = false;

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

  String _categoryLabel() {
    return _selectedCategory ?? "Tüm Kategoriler";
  }

  String _periodLabel() {
    switch (_selectedPeriodType) {
      case PeriodType.day:
        return DateFormat("dd.MM.yyyy").format(_selectedDate).toString();
      case PeriodType.month:
        return "${_selectedDate.year} ${months[_selectedDate.month - 1]}";
      case PeriodType.year:
        return "${_selectedDate.year.toString()} Yılı";
    }
  }

  String _transactionTypeLabel() {
    switch (_selectedTransactionType) {
      case FilterTransactionType.income:
        return "Gelir";
      case FilterTransactionType.expense:
        return "Gider";
      case FilterTransactionType.all:
        return "Tümü";
    }
  }

  void _resetFilters() {
    _selectedDate = widget.initialMonth;
    _selectedPeriodType = PeriodType.month;
    _selectedTransactionType = FilterTransactionType.all;
    _selectedCategory = null;
    _showFilter = false;
  }

  @override
  void initState() {
    super.initState();
    _resetFilters();
  }

  @override
  void didUpdateWidget(covariant AllTransactionsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.resetOnOpen != widget.resetOnOpen && widget.resetOnOpen) {
      setState(() {
        _resetFilters();
      });
    }
  }

  bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  @override
  Widget build(BuildContext context) {
    final all = context.watch<TransactionProvider>().allTransactions;
    final transactions = _applyFilters(all);

    final income = getTotalIncome(transactions);
    final expense = getTotalExpense(transactions);

    return Scaffold(
      appBar: AppBar(title: const Text("Tüm İşlemler")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color(0xFFB6D1F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          const Text(
                            "Filtre Ayarları",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showFilter = !_showFilter;
                                  });
                                },
                                icon: Icon(
                                  _showFilter
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                label: Text(_showFilter ? "Gizle" : "Göster"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _showFilter
                          ? Column(
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
                                        _selectedDate = DateTime(
                                          _selectedDate.year,
                                        );
                                      }
                                    });
                                  },
                                ),

                                const SizedBox(height: 8),
                                _buildPeriodPicker(),
                                const SizedBox(height: 8),

                                TransactionTypeSegmented(
                                  selected: _selectedTransactionType,
                                  onChanged: (type) {
                                    setState(() {
                                      _selectedTransactionType = type;
                                      _selectedCategory = null;
                                    });
                                  },
                                ),

                                const SizedBox(height: 8),
                                _buildCategoryPicker(),
                                const SizedBox(height: 8),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Card(
                    color: const Color(0xFFB6D1F2),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Tarih",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _periodLabel(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _transactionTypeLabel(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${transactions.length} işlem",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Kategori",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _categoryLabel(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  TransactionSummaryCard(income: income, expense: expense),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          transactions.isEmpty
              ? const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: EmptyTransactions(
                      message: "Seçili filtreler için işlem yok.",
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final tx = transactions[index];

                    return Dismissible(
                      key: ValueKey(tx.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context.read<TransactionProvider>().deleteTransaction(
                          tx.id,
                        );
                      },
                      child: Card(
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditTransactionScreen(
                                updatedTransactionModel: tx,
                              ),
                            ),
                          ),
                          leading: Text(
                            "${tx.date.day}/${tx.date.month}/${tx.date.year}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            tx.category,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            tx.comment,
                            textAlign: TextAlign.center,
                          ),
                          trailing: Text(
                            "₺${tx.amount}",
                            style: TextStyle(
                              color: tx.isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: transactions.length),
                ),
        ],
      ),
    );
  }
}
