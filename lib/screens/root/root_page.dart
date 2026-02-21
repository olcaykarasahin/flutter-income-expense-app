import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/all_transactions_screen/all_transactions_screen.dart';
import 'package:gelir_gider/screens/chart_screen/chart_screen.dart';
import 'package:gelir_gider/screens/home_screen/home_screen.dart';
import 'package:gelir_gider/screens/setting_screen/setting.screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _resetTransactions = false;
  bool _resetChartMonth = false;

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();

    final pages = [
      HomePage(
        selectedMonth: transactionProvider.selectedMonth,
        onOpenAllTransactions: (DateTime month) {
          context.read<TransactionProvider>().selectedMonth;

          setState(() {
            _currentIndex = 1;
            _resetTransactions = true;
          });
        },
      ),

      AllTransactionsScreen(
        initialMonth: transactionProvider.selectedMonth,
        resetOnOpen: _resetTransactions,
      ),

      ChartScreen(resetOnOpen: _resetChartMonth),

      const SettingPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,

        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;

            if (i == 1) {
              _resetTransactions = true;
            } else {
              _resetTransactions = false;
            }

            if (i == 2) {
              _resetChartMonth = true;
            } else {
              _resetChartMonth = false;
            }
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "İşlemler",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: "Grafik",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ayarlar"),
        ],
      ),
    );
  }
}
