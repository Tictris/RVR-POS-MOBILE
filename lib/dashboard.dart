import 'package:flutter/material.dart';
import 'package:rvr_flutter/widgets/input/input.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
            ),
            title: const Text('Roselyn View Resort')
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            children: [
              Center(child: Text(
                'Entrance',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),)),
                InputField(initialText: 'Adult'),
                InputField(initialText: 'Senior'),
                InputField(initialText: 'Child'),
                Center(child: Text('Total:')),
            ],
          ),
        ),
      ),
    );
  }
}