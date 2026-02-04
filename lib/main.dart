import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/root/root_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  // settingsProvider.setDarkMode(false);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider.value(value: settingsProvider),
      ],
      child: const GelirGiderApp(),
    ),
  );
}

class GelirGiderApp extends StatelessWidget {
  const GelirGiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        cardTheme: const CardThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF4A90E2)),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      darkTheme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
