import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';
import 'package:gelir_gider/screens/chart_screen/widget/chart_period_type_button_row.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

class ChartDateSelectorCard extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChangedDate;

  final ChartPeriodType selectedChartPeriodType;
  final ValueChanged<ChartPeriodType> onChangedPeriodType;
  const ChartDateSelectorCard({
    super.key,
    required this.selectedDate,
    required this.onChangedDate,

    required this.selectedChartPeriodType,
    required this.onChangedPeriodType,
  });
  String convertMonth() {
    return "${months[selectedDate.month - 1]} ${selectedDate.year}";
  }

  String convertYear() {
    return selectedDate.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ChartPeriodTypeButtonRow(
              selectedChartPeriodType: selectedChartPeriodType,
              onChanged: (periodType) {
                onChangedPeriodType(periodType);
              },
            ),
            selectedChartPeriodType == ChartPeriodType.month
                ? monthSelectorRow()
                : yearSelectorRow(),
          ],
        ),
      ),
    );
  }

  Row monthSelectorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            onChangedDate(DateTime(selectedDate.year, selectedDate.month - 1));
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
            onChangedDate(DateTime(selectedDate.year, selectedDate.month + 1));
          },
          icon: const Icon(Icons.arrow_circle_right),
          iconSize: 26,
        ),
      ],
    );
  }

  Row yearSelectorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            onChangedDate(DateTime(selectedDate.year - 1, selectedDate.month));
          },
          icon: const Icon(Icons.arrow_circle_left),
          iconSize: 26,
        ),
        Text(
          convertYear(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            onChangedDate(DateTime(selectedDate.year + 1, selectedDate.month));
          },
          icon: const Icon(Icons.arrow_circle_right),
          iconSize: 26,
        ),
      ],
    );
  }
}
