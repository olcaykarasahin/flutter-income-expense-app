// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum ActionType { income, expense }

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
            onPressed: onAddIncome,
            type: ActionType.income,
          ),

          const SizedBox(width: 10),

          ActionButton(
            buttonText: "Gider Ekle",
            buttonIcon: Icons.remove,
            type: ActionType.expense,
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
  final VoidCallback onPressed;
  final ActionType type;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color foregroundColor;

    switch (type) {
      case ActionType.income:
        backgroundColor = Colors.green;
        foregroundColor = colorScheme.onTertiary;
        break;
      case ActionType.expense:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        break;
    }

    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
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
