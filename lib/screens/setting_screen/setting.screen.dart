import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProviderRead = context.read<SettingsProvider>();
    final settingsProviderWatch = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Divider(),

            SwitchListTile(
              value: settingsProviderWatch.isDarkMode,
              title: const Text("Koyu Tema"),
              subtitle: const Text("Uygulamayı koyu renkte görüntüler"),
              onChanged: (value) {
                settingsProviderRead.setDarkMode(value);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Para Birimi"),
              trailing: Text(
                settingsProviderWatch.currency,
                style: const TextStyle(fontSize: 20),
              ),
              onTap: () =>
                  openShowModalBottomSheet(context, settingsProviderWatch),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void openShowModalBottomSheet(BuildContext context, provider) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF4A90E2),
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  context.read<SettingsProvider>().setCurrency("₺");
                  Navigator.pop(context);
                },
                title: Text(
                  textAlign: TextAlign.center,
                  "₺ (Türk Lirası)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: provider.currency == "₺" ? Colors.white : null,
                  ),
                ),
              ),

              ListTile(
                onTap: () {
                  context.read<SettingsProvider>().setCurrency("\$");
                  Navigator.pop(context);
                },
                title: Text(
                  textAlign: TextAlign.center,
                  "\$ (Us Doları)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: provider.currency == "\$" ? Colors.white : null,
                  ),
                ),
              ),

              ListTile(
                onTap: () {
                  context.read<SettingsProvider>().setCurrency("€");
                  Navigator.pop(context);
                },
                title: Text(
                  textAlign: TextAlign.center,
                  "€ (Euro)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: provider.currency == "€" ? Colors.white : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
