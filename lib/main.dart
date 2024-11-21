import 'package:flutter/material.dart';
import 'package:rvr_flutter/dashboard.dart';
// import 'package:rvr_flutter/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Dashboard(),
    );
  }
}
