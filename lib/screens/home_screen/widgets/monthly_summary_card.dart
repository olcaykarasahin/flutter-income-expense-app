// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/home_screen/widgets/month_picker_sheet.dart';
import 'package:provider/provider.dart';

class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<TransactionProvider>();
    final providerRead = context.read<TransactionProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => MonthPickerSheet(
                      initialYear: providerWatch.selectedMonth.year,
                      initialMonth: providerWatch.selectedMonth.month,
                      onSelected: (year, month) {
                        providerRead.setSelectedMonth(year, month);
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      providerWatch.selectedMonthLabel,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SummaryItem(
                    title: "Gelir",
                    value: "${providerWatch.totalIncome}₺",
                    color: Colors.green,
                  ),

                  _SummaryItem(
                    title: "Gider",
                    value: "${providerWatch.totalExpense}₺",
                    color: Colors.red,
                  ),

                  _SummaryItem(
                    title: "P&L",
                    value: "${providerWatch.netTotal}₺",
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
