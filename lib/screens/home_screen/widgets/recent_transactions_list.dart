import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class RecentTransactionsList extends StatelessWidget {
  const RecentTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transaction = provider.recentTransactions;
    return Column(
      children: [
        ...transaction.map(
          (transaction) => TransactionListItem(transaction: transaction),
        ),
      ],
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionListItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${transaction.date.day}.${transaction.date.month}.${transaction.date.year}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(transaction.paymentType.label),
          ],
        ),
        title: Center(
          child: Text(
            transaction.category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Center(
          child: Text(
            transaction.comment,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: Text(
          "${transaction.amount}₺",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: transaction.isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
