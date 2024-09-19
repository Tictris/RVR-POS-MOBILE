import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String initialText;

  const InputField({
    super.key,
    required this.initialText,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>  
 {
  late String _text;

  @override
  void initState() {
    super.initState();
    _text = widget.initialText;
  }

  void updateText(String newText) {
    setState(() {
      _text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  
 Column(
      children: [
        Text(_text),
        TextField(
          onChanged: updateText,
        ),
      ],
    );
  }
}