import 'package:flutter/material.dart';

class CommentTextFormField extends StatelessWidget {
  final TextEditingController commentcontroller;
  const CommentTextFormField({super.key, required this.commentcontroller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: commentcontroller,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      maxLength: 20,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.comment),
        labelText: "Açıklama",
        labelStyle: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
