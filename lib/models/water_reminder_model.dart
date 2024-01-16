import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class WaterReminderModel extends ChangeNotifier {
  int _waterIntake = 0;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int get waterIntake => _waterIntake;

  // Constructor to initialize the notification plugin
  WaterReminderModel() {
    initializeNotifications();
  }

  // Placeholder user getter, replace with actual user implementation
  get user => null;

  // Increment water intake and show notification every 3rd time
  Future<void> incrementWaterIntake() async {
    _waterIntake += 1;
    notifyListeners();

    if (_waterIntake % 3 == 0) {
      await showNotification();
    }
  }

  // Show a simple notification
  Future<void> showNotification() async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'water_reminder_channel',
      'Water Reminder',
      
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Drink Water',
      'Stay hydrated! Time to drink water.',
      platformChannelSpecifics,
    );
  }

  // Schedule a notification at a specific time
  Future<void> scheduleNotification(DateTime scheduledTime) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'water_reminder_channel',
      'Water Reminder',
     
      importance: Importance.max,
      priority: Priority.high,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Drink Water',
      'Stay hydrated! Time to drink water.',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Initialize notifications plugin
  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Placeholder sign out method
  void signOut() {
    // Implement sign out logic
  }

  // Placeholder sign up method
  void signUp(String email, String password) {
    // Implement sign up logic
  }

  // Placeholder sign in method
  void signIn(String email, String password) {
    // Implement sign in logic
  }
}
