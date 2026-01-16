import 'package:flutter/material.dart';

class MonthPickerSheet extends StatefulWidget {
  final void Function(int year, int month) onSelected;
  final int initialYear;
  final int initialMonth;

  const MonthPickerSheet({
    super.key,
    required this.onSelected,
    required this.initialYear,
    required this.initialMonth,
  });

  @override
  State<MonthPickerSheet> createState() => _MonthPickerSheetState();
}

class _MonthPickerSheetState extends State<MonthPickerSheet> {
  late int selectedYear;
  late int selectedMonth;

  static const months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık",
  ];

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialYear;
    selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Yıl Seç",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedYear--;
                  });
                },
                icon: const Icon(Icons.arrow_left),
                iconSize: 35,
              ),
              Text(
                "$selectedYear",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedYear++;
                  });
                },
                icon: const Icon(Icons.arrow_right),
                iconSize: 35,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Ay Seç",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: months.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final monthNumber = index + 1;
              final isSelected = monthNumber == selectedMonth;
              return InkWell(
                onTap: () {
                  widget.onSelected(selectedYear, index + 1);
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                  ),
                  child: Text(
                    months[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
