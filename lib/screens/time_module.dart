// TODO Implement this library.
// screens/time_module.dart

import 'package:flutter/material.dart';
import 'final_screen.dart';

class TimeModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Wake Up and Bedtime'),
        // Add your time selection UI here
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinalScreen()),
            );
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}
