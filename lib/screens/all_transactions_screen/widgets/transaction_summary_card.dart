import 'package:flutter/material.dart';

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
    final double net = income - expense;
    return Card(
      color: const Color(0xFFB6D1F2),

      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            _row("Toplam Gelir", income, Colors.green),

            _row("Toplam Gider", expense, Colors.red),

            _row("P&L", net, Colors.blue),
          ],
        ),
      ),
    );
  }

  Column _row(String label, double value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          "$value ₺",
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
