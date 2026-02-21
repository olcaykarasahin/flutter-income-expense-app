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
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Yıl Seç", style: Theme.of(context).textTheme.titleMedium),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedYear--;
                  });
                },
                icon: Icon(Icons.arrow_left, color: colorScheme.primary),
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
                icon: Icon(Icons.arrow_right, color: colorScheme.primary),
                iconSize: 35,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text("Ay Seç", style: Theme.of(context).textTheme.titleMedium),

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
                        ? colorScheme.primaryContainer
                        : colorScheme.surfaceContainerLow,
                  ),
                  child: Text(
                    months[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                    ),
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
