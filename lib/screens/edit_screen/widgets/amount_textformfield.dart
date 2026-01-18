import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: controller,

      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20),

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: isIncome ? "Gelir" : "Gider",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: isIncome ? Colors.green : Colors.red,
        ),
        prefixIcon: const Icon(Icons.currency_lira),
        prefixIconColor: isIncome ? Colors.green : Colors.red,
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
