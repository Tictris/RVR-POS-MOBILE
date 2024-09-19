import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your email address'),
        ),
      ],
    );
  }
}
