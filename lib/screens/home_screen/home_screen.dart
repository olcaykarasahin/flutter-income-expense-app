import 'package:flutter/material.dart';

import 'package:gelir_gider/screens/home_screen/widgets/monthly_summary_card.dart';
import 'package:gelir_gider/screens/home_screen/widgets/quick_actions_row.dart';

import 'package:gelir_gider/screens/home_screen/widgets/recent_transactions_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _handleAddIncome(BuildContext context) {
    debugPrint("Gelir ekle tıklandı");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MonthlySummaryCard()),
    // );
    // İleride: provider.addIncome()
  }

  void _handleAddExpense(BuildContext context) {
    debugPrint("Gider ekle tıklandı");
    // İleride: provider.addExpense()
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

            const RecentTransactionsSection(),
          ],
        ),
      ),
    );
  }
}
