// TODO Implement this library.
// screens/final_screen.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';

class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Water Animation'),
        // Add your water animation UI here
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          },
          child: Text('Finish Setup'),
        ),
      ],
    );
  }
}
