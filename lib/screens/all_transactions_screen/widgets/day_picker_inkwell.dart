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
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => openShowModalBottomSheet(context),
        child: Card(
          color: Colors.grey.shade300,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
            side: const BorderSide(color: Colors.black, width: 1.5),
          ),
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
      ),
    );
  }

  void openShowModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF4A90E2),

      context: context,
      builder: (_) {
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
                      border: Border.all(width: 2, color: Colors.grey),
                      color: selectedDate.day == day
                          ? Colors.black
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedDate.day == day
                              ? Colors.white
                              : Colors.black,
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
