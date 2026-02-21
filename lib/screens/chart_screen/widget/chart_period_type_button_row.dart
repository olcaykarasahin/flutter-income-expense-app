import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';

class ChartPeriodTypeButtonRow extends StatelessWidget {
  final ChartPeriodType selectedChartPeriodType;
  final ValueChanged<ChartPeriodType> onChanged;

  const ChartPeriodTypeButtonRow({
    super.key,
    required this.selectedChartPeriodType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<ChartPeriodType>(
        segments: const [
          ButtonSegment(
            value: ChartPeriodType.month,
            label: Text("AYLIK"),
            icon: Icon(Icons.calendar_month),
          ),
          ButtonSegment(
            value: ChartPeriodType.year,
            label: Text("YILLIK"),
            icon: Icon(Icons.event),
          ),
        ],
        selected: {selectedChartPeriodType},
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
          side: WidgetStateProperty.all(BorderSide(color: colorScheme.outline)),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
