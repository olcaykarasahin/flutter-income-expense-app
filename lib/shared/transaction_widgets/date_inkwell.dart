import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInkwell extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;
  const DateInkwell({super.key, required this.date, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _openModalBottomSheet(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "İşlem Tarihi",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF4A90E2),
          ),
          prefixIcon: Icon(Icons.event),
          border: OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Text(
              DateFormat("dd.MM.yyyy").format(date),
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _dateRow({
    required int value,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: onLeft,
          icon: const Icon(Icons.arrow_left, size: 40, color: Colors.white),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        IconButton(
          onPressed: onRight,
          icon: const Icon(Icons.arrow_right, size: 40, color: Colors.white),
        ),
      ],
    );
  }

  void _openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF4A90E2),

      context: context,
      builder: (_) {
        DateTime newDate = date;
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),

                  const Text(
                    "Gün",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  _dateRow(
                    value: newDate.day,
                    onLeft: () {
                      setState(() {
                        newDate = newDate.subtract(const Duration(days: 1));
                      });
                    },

                    onRight: () {
                      setState(() {
                        newDate = newDate.add(const Duration(days: 1));
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                  const Divider(height: 2, color: Colors.black),
                  const SizedBox(height: 10),

                  const Text(
                    "Ay",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  _dateRow(
                    value: newDate.month,
                    onLeft: () {
                      setState(() {
                        newDate = DateTime(
                          newDate.year,
                          newDate.month - 1,
                          newDate.day,
                        );
                      });
                    },
                    onRight: () {
                      setState(() {
                        newDate = DateTime(
                          newDate.year,
                          newDate.month + 1,
                          newDate.day,
                        );
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                  const Divider(height: 2, color: Colors.black),
                  const SizedBox(height: 10),

                  const Text(
                    "Yıl",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  _dateRow(
                    value: newDate.year,
                    onLeft: () {
                      setState(() {
                        newDate = DateTime(
                          newDate.year - 1,
                          newDate.month,
                          newDate.day,
                        );
                      });
                    },
                    onRight: () {
                      setState(() {
                        newDate = DateTime(
                          newDate.year + 1,
                          newDate.month,
                          newDate.day,
                        );
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                  const Divider(height: 2, color: Colors.black),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      onChanged(newDate);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Onayla",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
