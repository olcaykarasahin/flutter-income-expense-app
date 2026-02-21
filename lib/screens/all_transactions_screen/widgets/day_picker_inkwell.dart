import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayPickerInkwell extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;
  const DayPickerInkwell({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  String convertDate() {
    return DateFormat("dd.MM.yyyy").format(selectedDate).toString();
  }

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
        borderRadius: BorderRadius.circular(12),
        onTap: () => openShowModalBottomSheet(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                convertDate(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }

  void openShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final colorScheme = Theme.of(context).colorScheme;

        final totalDays = daysInMonth(selectedDate.year, selectedDate.month);

        List<int> days = List.generate(totalDays, (index) => index + 1);

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              final day = days[index];
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    onChanged(
                      DateTime(selectedDate.year, selectedDate.month, day),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 2, color: colorScheme.outline),
                      color: selectedDate.day == day
                          ? colorScheme.primaryContainer
                          : colorScheme.surface,
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedDate.day == day
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
