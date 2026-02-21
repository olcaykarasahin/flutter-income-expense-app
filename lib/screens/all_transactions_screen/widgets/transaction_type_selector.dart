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
    final colorScheme = Theme.of(context).colorScheme;
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
              return colorScheme.surfaceContainerLow;
            }

            switch (selected) {
              case FilterTransactionType.all:
                return colorScheme.primaryContainer;
              case FilterTransactionType.income:
                return Colors.green.shade200; // geçici
              case FilterTransactionType.expense:
                return colorScheme.errorContainer;
            }
          }),

          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return colorScheme.onSurface;
            }

            switch (selected) {
              case FilterTransactionType.all:
                return colorScheme.onPrimaryContainer;
              case FilterTransactionType.income:
                return Colors.green.shade900; // geçici
              case FilterTransactionType.expense:
                return colorScheme.onErrorContainer;
            }
          }),
          side: WidgetStateProperty.all(
            BorderSide(color: colorScheme.outline, width: 2),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
