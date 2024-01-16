// TODO Implement this library.// screens/get_started_screen.dart

import 'package:flutter/material.dart';
import 'setup_screen.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Started')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SetupScreen()),
            );
          },
          child: Text('Start Setup'),
        ),
      ),
    );
  }
}
