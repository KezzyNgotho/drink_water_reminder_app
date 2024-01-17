// TODO Implement this library.
// screens/gender_module.dart

import 'package:flutter/material.dart';
import 'weight_module.dart';

class GenderModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Gender'),
        // Add your gender selection UI here
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeightModule()),
            );
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}