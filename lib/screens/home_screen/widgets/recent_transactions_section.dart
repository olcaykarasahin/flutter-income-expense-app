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
    return Padding(
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
    );
  }

  Card transactionCard(BuildContext context, bool isEmpty) {
    return Card(
      child: ListTile(
        title: Text(
          "Son İşlemler",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: isEmpty
            ? null
            : TextButton(
                onPressed: () {
                  onSeeAll(selectedMonth);
                },
                child: const Text("Tümünü Gör"),
              ),
      ),
    );
  }
}
