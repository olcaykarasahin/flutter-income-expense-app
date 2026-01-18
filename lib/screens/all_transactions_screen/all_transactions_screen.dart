import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/edit_screen/edit_screen.dart';
import 'package:gelir_gider/screens/home_screen/widgets/empty_transactions.dart';
import 'package:provider/provider.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        context.watch<TransactionProvider>().filteredTransaction
          ..sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      appBar: AppBar(title: const Text("Tüm İşlemler")),
      body: transactions.isEmpty
          ? const Center(
              child: EmptyTransactions(
                message: "Seçili ay için işlem bulunmuyor.",
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Card(
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.shade600,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (direction) {
                      context.read<TransactionProvider>().deleteTransaction(
                        tx.id,
                      );
                    },
                    key: ValueKey(tx.id),

                    child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTransactionScreen(
                            updatedTransactionModel: tx,
                          ),
                        ),
                      ),
                      leading: Text(
                        "${tx.date.day}/"
                        "${tx.date.month}/"
                        "${tx.date.year}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Center(
                        child: Text(
                          tx.category,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          tx.comment,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trailing: Text(
                        "₺${tx.amount}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: tx.isIncome ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
