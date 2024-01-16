// TODO Implement this library.
// screens/setup_screen.dart

import 'package:flutter/material.dart';
import 'gender_module.dart';

class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup')),
      body: GenderModule(),
    );
  }
}
