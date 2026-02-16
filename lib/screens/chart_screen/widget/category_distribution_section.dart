import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';
import 'package:gelir_gider/screens/chart_screen/chart_calculator.dart';

class CategoryDistributionSection extends StatelessWidget {
  final Map<String, double> categoryTotals;
  final double grandTotal;
  final ChartType selectedChartType;
  final String currency;

  const CategoryDistributionSection({
    super.key,
    required this.categoryTotals,
    required this.grandTotal,
    required this.selectedChartType,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categoryTotals.entries.map((entry) {
        final category = entry.key;
        final amount = entry.value;
        final percentage = calculatePercentage(amount, grandTotal);
        return Padding(
          padding: const EdgeInsetsGeometry.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category),
                  Text(
                    "%${percentage.toStringAsFixed(0)} ${amount.toStringAsFixed(0)} $currency",
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                color: selectedChartType == ChartType.income
                    ? Colors.green
                    : Colors.red,
                backgroundColor: selectedChartType == ChartType.income
                    ? Colors.green.shade200
                    : Colors.red.shade200,
                value: grandTotal == 0 ? 0 : amount / grandTotal,

                minHeight: 8,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
