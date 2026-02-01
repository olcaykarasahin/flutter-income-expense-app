import 'package:flutter/material.dart';

class YearPickerInkwell extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;
  const YearPickerInkwell({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });
  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.black),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                final newYear = selectedDate.year - 1;
                final maxDay = daysInMonth(newYear, selectedDate.month);
                final safeDay = selectedDate.day.clamp(1, maxDay);

                onChanged(DateTime(newYear, selectedDate.month, safeDay));
              },
              iconSize: 26,
              icon: const Icon(Icons.arrow_circle_left, color: Colors.black87),
            ),
            Text(
              selectedDate.year.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                final newYear = selectedDate.year + 1;
                final maxDay = daysInMonth(newYear, selectedDate.month);
                final safeDay = selectedDate.day.clamp(1, maxDay);

                onChanged(DateTime(newYear, selectedDate.month, safeDay));
              },
              iconSize: 26,

              icon: const Icon(Icons.arrow_circle_right, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
