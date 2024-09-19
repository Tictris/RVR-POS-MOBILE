import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your password'),
        ),
      ],
    );
  }
}
