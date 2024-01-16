// TODO Implement this library.
// screens/weight_module.dart

import 'package:flutter/material.dart';
import 'time_module.dart';

class WeightModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Weight'),
        // Add your weight selection UI here
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeModule()),
            );
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}
