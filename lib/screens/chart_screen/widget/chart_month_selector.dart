import 'package:flutter/material.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

class ChartMonthSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const ChartMonthSelector({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });
  String convertMonth() {
    return "${months[selectedDate.month - 1]} ${selectedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                onChanged(DateTime(selectedDate.year, selectedDate.month - 1));
              },
              icon: const Icon(Icons.arrow_circle_left),
              iconSize: 26,
            ),
            Text(
              convertMonth(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                onChanged(DateTime(selectedDate.year, selectedDate.month + 1));
              },
              icon: const Icon(Icons.arrow_circle_right),
              iconSize: 26,
            ),
          ],
        ),
      ),
    );
  }
}
