import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/all_transactions_screen/all_transactions_screen.dart';

class TransactionTypeSegmented extends StatelessWidget {
  final FilterTransactionType selected;
  final ValueChanged<FilterTransactionType> onChanged;
  const TransactionTypeSegmented({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<FilterTransactionType>(
        segments: const [
          ButtonSegment(
            value: FilterTransactionType.all,
            label: Text("Tümü"),
            icon: Icon(Icons.list_alt),
          ),
          ButtonSegment(
            value: FilterTransactionType.income,
            label: Text("Gelir"),
            icon: Icon(Icons.trending_up),
          ),
          ButtonSegment(
            value: FilterTransactionType.expense,
            label: Text("Gider"),
            icon: Icon(Icons.trending_down),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (value) {
          onChanged(value.first);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return Colors.grey.shade200;
            }

            if (selected == FilterTransactionType.all) {
              return Colors.blue.shade300;
            }
            if (selected == FilterTransactionType.income) {
              return Colors.green;
            }
            if (selected == FilterTransactionType.expense) {
              return Colors.red;
            }

            return Colors.grey;
          }),

          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.black; // seçili yazı/icon
            }
            return Colors.black54;
          }),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
