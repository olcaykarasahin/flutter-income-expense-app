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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedChartType == ChartType.income
                ? Colors.green
                : Colors.green.shade300,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onChanged(ChartType.income);
          },
          child: const Text("Gelir"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedChartType == ChartType.expense
                ? Colors.red
                : Colors.red.shade300,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onChanged(ChartType.expense);
          },
          child: const Text("Gider"),
        ),
      ],
    );
  }
}
