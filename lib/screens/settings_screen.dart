import 'package:drink_water_reminder/screens/history_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 1; // Set the initial active item (Settings)
late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildReminderSettings(context),
          const Divider(height: 20, thickness: 2),
          _buildGeneralSettings(),
          const Divider(height: 20, thickness: 2),
          _buildPersonalSettings(),
          const Divider(height: 20, thickness: 2),
          _buildResetDataOption(context),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        height: 60.0,
        items: _buildNavigationBarItems(),
        onTap: (index) => _handleBottomNavigationBarTap(index),
        index: 2,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
      ),
    );
  }

  List<Widget> _buildNavigationBarItems() {
    return [
      Icon(Icons.home, size: 30),
      Icon(Icons.history, size: 30),
      Icon(Icons.settings, size: 30),
    ];
  }

 void _handleBottomNavigationBarTap(int index) {
  // Handle navigation
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryScreen(intakeHistory: [],)),
    );
  } else if (index == 0) {
    // Use _animationController.animateTo to smoothly animate to the Settings tab
    _animationController.animateTo(0);
  }
}


  Widget _buildReminderSettings(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reminder Settings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            _buildSettingItem('Reminder Schedule', 'Set the time for daily reminders'),
            _buildSettingItem('Reminder Sound', 'Choose the sound for reminders'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showReminderDialog(context);
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderDialog(BuildContext context) {
    TimeOfDay? selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Reminder'),
          content: Column(
            children: [
              Text('Choose the time for your daily reminder.'),
              const SizedBox(height: 16.0),
              ListTile(
                title: Text('Set Time'),
                subtitle: Text(selectedTime != null ? selectedTime!.format(context) : 'Select a time'),
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );
                  if (newTime != null) {
                    selectedTime = newTime;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement reminder setting logic
                Navigator.pop(context);
              },
              child: Text('Set'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGeneralSettings() {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            _buildSettingItem('Theme', 'Light or Dark interface'),
            _buildSettingItem('Language', 'Choose your preferred language'),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalSettings() {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Settings',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            _buildSettingItem('Gender', 'Select your gender'),
            _buildSettingItem('Weight', 'Enter your weight'),
            _buildSettingItem('Wakeup Time', 'Set your wakeup time'),
            _buildSettingItem('Bedtime', 'Set your bedtime'),
          ],
        ),
      ),
    );
  }

  Widget _buildResetDataOption(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        title: Text(
          'Reset Data',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Erase all data and start fresh'),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Reset Data'),
                content: Text('Are you sure you want to reset all data?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Implement reset data logic
                      Navigator.pop(context);
                    },
                    child: Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSettingItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(description),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
