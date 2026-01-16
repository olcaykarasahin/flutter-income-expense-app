import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  final String message;
  const EmptyTransactions({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 56),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
