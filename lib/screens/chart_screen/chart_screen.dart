import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/chart_screen/chart_calculator.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:gelir_gider/screens/chart_screen/widget/chart_month_selector.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  final bool resetOnOpen;

  const ChartScreen({super.key, required this.resetOnOpen});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = context.read<TransactionProvider>().selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    final allTransactions = context
        .watch<TransactionProvider>()
        .allTransactions;
    final transactions = filterByMonth(allTransactions, selectedDate);

    final totalExpense = calculateTotalExpense(transactions);
    final totalIncome = calculateTotalIncome(transactions);
    final isEmptyMonth = totalIncome == 0 && totalExpense == 0;

    return Scaffold(
      appBar: AppBar(title: const Text("Grafik"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ChartMonthSelector(
              selectedDate: selectedDate,
              onChanged: (value) {
                setState(() {
                  selectedDate = value;
                });
              },
            ),

            const SizedBox(height: 12),

            isEmptyMonth
                ? _blankChart()
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
                            _summaryRow(context, totalExpense, totalIncome),

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
          ],
        ),
      ),
    );
  }

  BarChart _incomeExpenseBarChart(double totalIncome, double totalExpense) {
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
                    return _labelText("Gelir");
                  case 1:
                    return _labelText("Gider");
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),

        alignment: BarChartAlignment.spaceAround,

        maxY: (totalIncome > totalExpense ? totalIncome : totalExpense) * 1.2,

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

  Card _blankChart() {
    return Card(
      child: SizedBox(
        height: 170,
        child: Center(
          child: _labelText("Seçili Aya Ait Gelir Ve Gider Girilmemiş"),
        ),
      ),
    );
  }

  Text _labelText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Row _summaryRow(
    BuildContext context,
    double totalExpense,
    double totalIncome,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Column(
          children: [
            Row(
              children: [
                _labelText("Gelir: "),
                _labelText(
                  "$totalIncome ${context.watch<SettingsProvider>().currency}",
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                _labelText("Gider: "),
                _labelText(
                  "$totalExpense ${context.watch<SettingsProvider>().currency}",
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
      });
    }
  }
}
