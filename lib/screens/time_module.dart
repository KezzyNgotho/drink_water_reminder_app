import 'package:flutter/material.dart';
import 'final_screen.dart';

class TimeModule extends StatefulWidget {
  @override
  _TimeModuleState createState() => _TimeModuleState();
}

class _TimeModuleState extends State<TimeModule> {
  TimeOfDay selectedWakeUpTime = TimeOfDay(hour: 7, minute: 0); // Default wake-up time
  TimeOfDay selectedBedtime = TimeOfDay(hour: 22, minute: 0); // Default bedtime

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time?'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeMessage(),
              SizedBox(height: 40.0),
              _buildTimeSelector(
                'Wake Up Time',
                selectedWakeUpTime,
                (TimeOfDay time) {
                  setState(() {
                    selectedWakeUpTime = time;
                  });
                },
              ),
              SizedBox(height: 20.0),
              _buildTimeSelector(
                'Bedtime',
                selectedBedtime,
                (TimeOfDay time) {
                  setState(() {
                    selectedBedtime = time;
                  });
                },
              ),
              SizedBox(height: 40.0),
              _buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Text(
      'Let\'s set up your daily routine.\nSelect your wake-up and bedtime:',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTimeSelector(
    String label,
    TimeOfDay selectedTime,
    Function(TimeOfDay) onTimeChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (newTime != null) {
                  onTimeChanged(newTime);
                }
              },
            ),
            SizedBox(width: 10.0),
            Text(
              selectedTime.format(context),
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the FinalScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FinalScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Next',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
