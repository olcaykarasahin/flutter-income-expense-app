import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AmountTextFormFieldWidget extends StatelessWidget {
  final bool isIncome;
  final TextEditingController controller;

  const AmountTextFormFieldWidget({
    super.key,
    required this.isIncome,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final currency = context.read<SettingsProvider>().currency;
    return TextFormField(
      controller: controller,

      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Tutar Giriniz",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: isIncome ? Colors.green : Colors.red,
        ),
        suffixText: currency,
        suffixStyle: TextStyle(
          color: isIncome ? Colors.green : Colors.red,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Tutar giriniz';
        }

        final normalized = value.replaceAll(',', '.');

        final isValidNumber = RegExp(r'^\d+(\.\d+)?$').hasMatch(normalized);

        if (!isValidNumber) {
          return 'Geçersiz tutar formatı';
        }

        final amount = double.tryParse(normalized);

        if (amount == null || amount <= 0) {
          return 'Tutar 0\'dan büyük olmalı';
        }

        return null;
      },
    );
  }
}
