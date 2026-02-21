import 'package:flutter/material.dart';
import 'package:gelir_gider/core/theme/app_theme.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/screens/root/root_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}
