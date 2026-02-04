import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _currency = "₺";

  bool get isDarkMode => _isDarkMode;
  String get currency => _currency;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("darkMode", value);
    });
  }

  void setCurrency(String value) {
    _currency = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("currency", value);
    });
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("darkMode") ?? false;
    _currency = prefs.getString("currency") ?? "₺";
    notifyListeners();
  }
}
