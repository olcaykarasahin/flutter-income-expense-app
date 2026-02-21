import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/all_transactions_screen/all_transactions_screen.dart';

class PeriodTypeSegmented extends StatelessWidget {
  final PeriodType selected;
  final ValueChanged<PeriodType> onChanged;

  const PeriodTypeSegmented({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<PeriodType>(
        segments: const [
          ButtonSegment(
            value: PeriodType.day,
            label: Text("Gün"),
            icon: Icon(Icons.today),
          ),
          ButtonSegment(
            value: PeriodType.month,
            label: Text("Ay"),
            icon: Icon(Icons.calendar_month),
          ),
          ButtonSegment(
            value: PeriodType.year,
            label: Text("Yıl"),
            icon: Icon(Icons.event),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (value) {
          onChanged(value.first);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primaryContainer;
            }
            return colorScheme.surfaceContainerLow;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.onPrimaryContainer;
            }
            return colorScheme.onSurface;
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
