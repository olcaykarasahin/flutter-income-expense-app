import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class TransactionSummaryCard extends StatelessWidget {
  final double income;
  final double expense;

  const TransactionSummaryCard({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double net = income - expense;
    final bool isProfit = net >= 0;
    final currency = context.watch<SettingsProvider>().currency;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            _row(context, "Toplam Gelir", income, Colors.green, currency),
            _row(context, "Toplam Gider", expense, colorScheme.error, currency),
            _row(
              context,
              "P&L",
              net,
              isProfit ? Colors.green : colorScheme.error,
              currency,
            ),
          ],
        ),
      ),
    );
  }

  Column _row(
    BuildContext context,
    String label,
    double value,
    Color color,
    String currency,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          "$value $currency",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
