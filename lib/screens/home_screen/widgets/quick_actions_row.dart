// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  final VoidCallback onAddIncome;
  final VoidCallback onAddExpense;

  const QuickActionsRow({
    super.key,
    required this.onAddIncome,
    required this.onAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ActionButton(
            buttonText: "Gelir Ekle",
            buttonIcon: Icons.add,
            textColor: Colors.white,
            buttonColor: Colors.green,
            onPressed: onAddIncome,
          ),

          const SizedBox(width: 10),

          ActionButton(
            buttonText: "Gider Ekle",
            buttonIcon: Icons.remove,
            textColor: Colors.white,
            buttonColor: Colors.red,
            onPressed: onAddExpense,
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.textColor,
    required this.buttonColor,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          iconSize: 22,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(buttonIcon), Text(buttonText)],
        ),
      ),
    );
  }
}
