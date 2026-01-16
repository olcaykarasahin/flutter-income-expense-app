import 'package:flutter/material.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İşlem Değişikliği"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            color: Color(0xFF4A90E2),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Update Form Sayfası")],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
