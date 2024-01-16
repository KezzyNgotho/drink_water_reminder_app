import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drink_water_reminder/models/water_reminder_model.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waterReminderModel = Provider.of<WaterReminderModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Implement login logic
                waterReminderModel.signIn('example@email.com', 'password');
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement registration logic
                waterReminderModel.signUp('newuser@email.com', 'password');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
