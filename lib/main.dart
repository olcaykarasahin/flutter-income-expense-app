import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: const GelirGiderApp(),
    ),
  );
}

class GelirGiderApp extends StatelessWidget {
  const GelirGiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        cardTheme: CardThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF4A90E2)),
        scaffoldBackgroundColor: Color(0xFFF7F9FC),
      ),
      home: HomePage(),
    );
  }
}
