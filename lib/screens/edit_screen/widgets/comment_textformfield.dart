import 'package:flutter/material.dart';

class CommentTextFormField extends StatelessWidget {
  final TextEditingController commentcontroller;
  const CommentTextFormField({super.key, required this.commentcontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: commentcontroller,
      style: const TextStyle(fontSize: 20),
      maxLength: 20,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.comment),
        labelText: "Açıklama",
        labelStyle: TextStyle(
          color: Color(0xFF4A90E2),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
