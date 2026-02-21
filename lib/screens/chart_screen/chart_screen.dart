import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/chart_screen/chart_calculator.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:gelir_gider/screens/chart_screen/widget/category_distribution_section.dart';
import 'package:gelir_gider/screens/chart_screen/widget/chart_date_selector_card.dart';
import 'package:gelir_gider/screens/chart_screen/widget/chart_type_button_row.dart';
import 'package:provider/provider.dart';

enum ChartType { income, expense }

enum ChartPeriodType { month, year }

class ChartScreen extends StatefulWidget {
  final bool resetOnOpen;

  const ChartScreen({super.key, required this.resetOnOpen});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late DateTime selectedDate;
  late ChartType selectedChartType;
  late ChartPeriodType selectedPeriodType;

  @override
  void initState() {
    super.initState();
    selectedDate = context.read<TransactionProvider>().selectedMonth;
    selectedChartType = ChartType.expense;
    selectedPeriodType = ChartPeriodType.month;
  }

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SettingsProvider>().currency;

    final allTransactions = context
        .watch<TransactionProvider>()
        .allTransactions;
    final transactions = selectedPeriodType == ChartPeriodType.month
        ? filterByMonth(allTransactions, selectedDate)
        : filterByYear(allTransactions, selectedDate);

    final totalExpense = calculateTotalExpense(transactions);
    final totalIncome = calculateTotalIncome(transactions);
    final isEmptyMonth = totalIncome == 0 && totalExpense == 0;
    final categoryTotals = calculateCategoryTotals(
      transactions,
      selectedChartType,
    );

    final grandTotal = calculateGrandTotal(categoryTotals);

    return Scaffold(
      appBar: AppBar(title: const Text("Grafik"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChartDateSelectorCard(
                selectedDate: selectedDate,
                selectedChartPeriodType: selectedPeriodType,
                onChangedDate: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                onChangedPeriodType: (ChartPeriodType periodType) {
                  setState(() {
                    selectedPeriodType = periodType;
                  });
                },
              ),

              const SizedBox(height: 12),

              isEmptyMonth
                  ? _blankChart(selectedPeriodType)
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          height: 240,
                          child: Column(
                            children: [
                              _summaryRow(totalExpense, totalIncome, currency),

                              Expanded(
                                child: _incomeExpenseBarChart(
                                  totalIncome,
                                  totalExpense,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              if (!isEmptyMonth)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ChartTypeButtonRow(
                          selectedChartType: selectedChartType,
                          onChanged: (chartType) {
                            setState(() {
                              if (selectedChartType != chartType) {
                                selectedChartType = chartType;
                              }
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: CategoryDistributionSection(
                            categoryTotals: categoryTotals,
                            grandTotal: grandTotal,
                            selectedChartType: selectedChartType,
                            currency: currency,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BarChart _incomeExpenseBarChart(double totalIncome, double totalExpense) {
    final maxValue =
        (totalIncome > totalExpense ? totalIncome : totalExpense) * 1.2;

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return _labelText(context, "Gelir");
                  case 1:
                    return _labelText(context, "Gider");
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),

        alignment: BarChartAlignment.spaceAround,

        maxY: maxValue == 0 ? 100 : maxValue,

        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: totalIncome,
                color: Colors.green,
                width: 28,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: totalExpense,
                color: Colors.red,
                width: 28,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card _blankChart(ChartPeriodType selectedPeriodType) {
    return Card(
      child: SizedBox(
        height: 170,
        child: Center(
          child: _labelText(
            context,
            selectedPeriodType == ChartPeriodType.month
                ? "Seçili Aya Ait Gelir Ve Gider Girilmemiş"
                : "Seçili Yıla Ait Gelir Ve Gider Girilmemiş",
          ),
        ),
      ),
    );
  }

  Text _labelText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Row _summaryRow(double totalExpense, double totalIncome, String currency) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  "Gelir: $totalIncome $currency",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  "Gider: $totalExpense $currency",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant ChartScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetOnOpen != widget.resetOnOpen && widget.resetOnOpen) {
      setState(() {
        selectedDate = context.read<TransactionProvider>().selectedMonth;
        selectedPeriodType = ChartPeriodType.month;
      });
    }
  }
}
