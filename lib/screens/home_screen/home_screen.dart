import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';

import 'package:gelir_gider/screens/add_screen/add_screen.dart';

import 'package:gelir_gider/screens/home_screen/widgets/monthly_summary_card.dart';
import 'package:gelir_gider/screens/home_screen/widgets/quick_actions_row.dart';

import 'package:gelir_gider/screens/home_screen/widgets/recent_transactions_section.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final DateTime selectedMonth;
  final void Function(DateTime month) onOpenAllTransactions;

  const HomePage({
    super.key,
    required this.selectedMonth,
    required this.onOpenAllTransactions,
  });

  Future<void> _handleAddIncome(BuildContext context) async {
    final month = context.read<TransactionProvider>().selectedMonth;
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddScreen(isIncome: true)),
    );

    if (saved == true) {
      onOpenAllTransactions(month);
    }
  }

  Future<void> _handleAddExpense(BuildContext context) async {
    final month = context.read<TransactionProvider>().selectedMonth;
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddScreen(isIncome: false)),
    );

    if (saved == true) {
      onOpenAllTransactions(month);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gelir - Gider Anasayfa"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const MonthlySummaryCard(),

            QuickActionsRow(
              onAddIncome: () => _handleAddIncome(context),
              onAddExpense: () => _handleAddExpense(context),
            ),

            RecentTransactionsSection(
              selectedMonth: selectedMonth,
              onSeeAll: (month) {
                onOpenAllTransactions(month);
              },
            ),
          ],
        ),
      ),
    );
  }
}
