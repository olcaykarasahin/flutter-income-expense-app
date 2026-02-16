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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedChartPeriodType == ChartPeriodType.month
                ? Colors.blue
                : Colors.blue.shade200,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onChanged(ChartPeriodType.month);
          },
          child: const Text("AYLIK"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedChartPeriodType == ChartPeriodType.year
                ? Colors.blue
                : Colors.blue.shade200,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onChanged(ChartPeriodType.year);
          },
          child: const Text("YILLIK"),
        ),
      ],
    );
  }
}
