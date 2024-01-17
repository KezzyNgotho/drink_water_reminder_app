// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/get_started_screen.dart';
import 'models/water_reminder_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterReminderModel(),
      child: MaterialApp(
        title: 'Water Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: GetStartedScreen(),
      ),
    );
  }
}