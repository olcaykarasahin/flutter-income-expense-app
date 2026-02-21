import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';

class ChartTypeButtonRow extends StatelessWidget {
  final ChartType selectedChartType;
  final ValueChanged<ChartType> onChanged;

  const ChartTypeButtonRow({
    super.key,
    required this.selectedChartType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<ChartType>(
        segments: const [
          ButtonSegment(
            value: ChartType.income,
            label: Text("Gelir"),
            icon: Icon(Icons.trending_up),
          ),
          ButtonSegment(
            value: ChartType.expense,
            label: Text("Gider"),
            icon: Icon(Icons.trending_down),
          ),
        ],
        selected: {selectedChartType},
        onSelectionChanged: (value) {
          onChanged(value.first);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return colorScheme.surfaceContainerLow;
            }

            if (selectedChartType == ChartType.income) {
              return Colors.green.shade300;
            } else {
              return colorScheme.errorContainer;
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return colorScheme.onSurface;
            }

            if (selectedChartType == ChartType.income) {
              return Colors.white;
            } else {
              return colorScheme.onErrorContainer;
            }
          }),
          side: WidgetStateProperty.all(BorderSide(color: colorScheme.outline)),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
