import 'package:flutter/material.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

class MonthPickerInkwell extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;
  const MonthPickerInkwell({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  String convertDate() {
    return "${months[selectedDate.month - 1]} ${selectedDate.year}";
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
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: months.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            final month = months[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  final maxDay = daysInMonth(selectedDate.year, index + 1);
                  final safeDay = selectedDate.day.clamp(1, maxDay);

                  onChanged(DateTime(selectedDate.year, index + 1, safeDay));
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2, color: Colors.grey),
                    color: selectedDate.month - 1 == index
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      month.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: selectedDate.month - 1 == index
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
        );
      },
    );
  }
}
