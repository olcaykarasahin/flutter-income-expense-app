import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/home_screen/widgets/empty_transactions.dart';
import 'package:gelir_gider/screens/home_screen/widgets/recent_transactions_list.dart';

import 'package:provider/provider.dart';

class RecentTransactionsSection extends StatelessWidget {
  final void Function(DateTime month) onSeeAll;

  final DateTime selectedMonth;

  const RecentTransactionsSection({
    super.key,
    required this.selectedMonth,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = context
        .watch<TransactionProvider>()
        .filteredTransaction
        .isEmpty;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB6D1F2),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            transactionCard(context, isEmpty),
            const SizedBox(height: 10),
            isEmpty
                ? const EmptyTransactions(
                    message:
                        'Bu ay için henüz işlem yok.\nÜstteki butonları kullanarak gelir veya gider ekleyebilirsin.',
                  )
                : const RecentTransactionsList(),
          ],
        ),
      ),
    );
  }

  Card transactionCard(BuildContext context, bool isEmpty) {
    return Card(
      child: isEmpty
          ? const ListTile(
              title: Text(
                "Son İşlemler",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : ListTile(
              title: const Text(
                "Son İşlemler",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: GestureDetector(
                onTap: () {
                  onSeeAll(selectedMonth);
                },

                child: const Text(
                  "Tümünü Gör...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
    );
  }
}
