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
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline, width: 2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
              icon: Icon(
                Icons.arrow_circle_left,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              selectedDate.year.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
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

              icon: Icon(
                Icons.arrow_circle_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
