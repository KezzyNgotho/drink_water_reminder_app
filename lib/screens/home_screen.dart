import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'history_screen.dart';
import 'water_progress.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  double targetWater = 3000.0;
  double consumedWater = 2000.0;
  double currentIntake = 0.0;
  List<Map<String, dynamic>> intakeHistory = [];
  List<String> welcomeMessages = [
    'Stay hydrated and healthy!',
    'Did you drink water today?',
    'A glass of water can make a big difference!',
    'Cheers to a refreshing day!',
  ];
  int currentMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Timer.periodic(Duration(seconds: 5), (timer) {
      _changeWelcomeMessage();
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = consumedWater / targetWater;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Water Reminder'),
        toolbarHeight: 30.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: [
            _buildWaterProgress(percentage),
            _buildWaterInfo(percentage),
            _buildButtons(),
            _buildIntakeHistoryCard(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        height: 60.0,
        items: _buildNavigationBarItems(),
        onTap: (index) => _handleBottomNavigationBarTap(index),
        index: 0,
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
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HistoryScreen(intakeHistory: intakeHistory)),
      );
    } else if (index == 2) {
      _animationController.animateTo(2);
    }
  }

  Widget _buildWaterProgress(double percentage) {
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        child: CustomPaint(
          painter: WaterProgressPainter(percentage: percentage, target: targetWater),
        ),
      ),
    );
  }

 Widget _buildWaterInfo(double percentage) {
    String nextIntakeTime = _calculateNextIntakeTime();
    double nextIntakeAmount = targetWater * 0.08; // You can adjust this percentage as needed

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInfoColumn(Icons.local_drink, 'Should Take', (percentage * targetWater).toInt().toString() + 'ml'),
          SizedBox(width: 40.0),
          _buildInfoColumn(Icons.local_bar, 'Water Intake', currentIntake.toInt().toString() + 'ml'),
          SizedBox(width: 40.0),
          _buildInfoColumn(Icons.access_time, 'Next Intake', '$nextIntakeTime\n${nextIntakeAmount.toInt()}ml'),
        ],
      ),
    );
  }




  Widget _buildInfoColumn(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 40.0, color: Colors.blue),
        Text(title, style: TextStyle(fontSize: 16.0)),
        Text(value, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => _showIntakeConfirmationDialog(),
            child: Text('Confirm Intake'),
          ),
        ],
      ),
    );
  }
Widget _buildIntakeHistoryCard() {
  return Card(
    elevation: 5.0,
    margin: const EdgeInsets.all(10.0),
    color: Colors.lightBlueAccent, // Adjust the card color
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Today's Intake History",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white), // Adjust text color
          ),
          const SizedBox(height: 10.0),
          if (intakeHistory.isNotEmpty)
            Container(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < intakeHistory.length; i++)
                    Container(
                      width: MediaQuery.of(context).size.width / 3 - 20, // Adjust the width of each column
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        title: Text('Intake: ${intakeHistory[i]['intake'].toInt()}ml'),
                        subtitle: Text('Time: ${intakeHistory[i]['time']}'),
                      ),
                    ),
                ],
              ),
            )
          else
            Text('No intake recorded yet.', style: TextStyle(color: const Color.fromARGB(255, 194, 35, 35))), // Adjust text color
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => _recordUnrecordedIntake(context),
            child: Text('Fill Unrecorded Intake'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Adjust button background color
              onPrimary: Colors.blue, // Adjust button text color
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust button padding
            ),
          ),
        ],
      ),
    ),
  );
}


Widget _buildIntakeColumn(List<Map<String, dynamic>> intakeHistory, int columnIndex) {
  return Expanded(
    child: Column(
      children: [
        for (int i = columnIndex * 3; i < (columnIndex + 1) * 3 && i < intakeHistory.length; i++)
          ListTile(
            title: Text('Intake: ${intakeHistory[i]['intake'].toInt()}ml'),
            subtitle: Text('Time: ${intakeHistory[i]['time']}'),
          ),
      ],
    ),
  );
}

  void _showIntakeConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Water Intake'),
          content: Text('Have you taken ${currentIntake.toInt()}ml of water?'),
          actions: [
            TextButton(
              onPressed: () {
                _confirmIntake();
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
  }
void _confirmIntake() {
  setState(() {
    consumedWater += currentIntake;
    intakeHistory.add({
      'label': 'Confirmed Intake',
      'intake': currentIntake,
      'time': _getCurrentTime(),
    });
    currentIntake = 0.0;

    // Check if it's time for the next intake
    if (_isTimeForNextIntake()) {
      _showNextIntakeReminderDialog();
    }
  });
}

void _recordUnrecordedIntake(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController timeController = TextEditingController();
      TextEditingController intakeController = TextEditingController();

      return AlertDialog(
        title: Text('Record Unrecorded Intake'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select the time and amount you took water:'),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Select time',
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          timeController.text =
                              '${selectedTime.hour}:${selectedTime.minute}';
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: intakeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount (ml)',
                        hintText: 'Enter amount',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              double unrecordedIntake = double.parse(intakeController.text);
              String selectedTime = timeController.text.isNotEmpty
                  ? timeController.text
                  : _getCurrentTime();

              setState(() {
                consumedWater += unrecordedIntake;
                intakeHistory.add({
                  'label': 'Unrecorded Intake',
                  'intake': unrecordedIntake,
                  'time': selectedTime,
                });

                // Check if it's time for the next intake
                if (_isTimeForNextIntake()) {
                  _showNextIntakeReminderDialog();
                }
              });

              Navigator.pop(context);
            },
            child: Text('Record'),
          ),
        ],
      );
    },
  );
}

  void _showTodayIntakeHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Today's Intake History"),
          content: Column(
            children: [
              for (var entry in intakeHistory)
                Text('${entry['label']}: ${entry['intake'].toInt()}ml'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _recordIntakeManually() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Record Water Intake'),
          content: Column(
            children: [
              Text('Enter the amount you want to record manually:'),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _recordManually(controller);
                Navigator.pop(context);
              },
              child: Text('Record'),
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

  void _recordManually(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController timeController = TextEditingController();
          return AlertDialog(
            title: Text('Record Water Intake'),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select the time and amount you took water:'),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: timeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Time',
                            hintText: 'Select time',
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              timeController.text =
                                  '${selectedTime.hour}:${selectedTime.minute}';
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount (ml)',
                            hintText: 'Enter amount',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  double manuallyRecordedIntake = double.parse(controller.text);
                  String selectedTime = timeController.text.isNotEmpty
                      ? timeController.text
                      : _getCurrentTime();

                  setState(() {
                    consumedWater += manuallyRecordedIntake;
                    intakeHistory.add({
                      'label': 'Manually Recorded',
                      'intake': manuallyRecordedIntake,
                      'time': selectedTime,
                    });
                  });

                  Navigator.pop(context);
                },
                child: Text('Record'),
              ),
            ],
          );
        },
      );
    }
  }

  String _getCurrentTime() {
    var now = DateTime.now();
    return '${now.hour}:${now.minute}';
  }

  void _changeWelcomeMessage() {
    setState(() {
      currentMessageIndex = (currentMessageIndex + 1) % welcomeMessages.length;
    });
  }
/*
 void _recordUnrecordedIntake(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController timeController = TextEditingController();
        TextEditingController intakeController = TextEditingController();

        return AlertDialog(
          title: Text('Record Unrecorded Intake'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select the time and amount you took water:'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: timeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Time',
                          hintText: 'Select time',
                          suffixIcon: Icon(Icons.access_time),
                        ),
                        onTap: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            timeController.text =
                                '${selectedTime.hour}:${selectedTime.minute}';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: intakeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount (ml)',
                          hintText: 'Enter amount',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double unrecordedIntake = double.parse(intakeController.text);
                String selectedTime = timeController.text.isNotEmpty
                    ? timeController.text
                    : _getCurrentTime();

                setState(() {
                  consumedWater += unrecordedIntake;
                  intakeHistory.add({
                    'label': 'Unrecorded Intake',
                    'intake': unrecordedIntake,
                    'time': selectedTime,
                  });
                });

                Navigator.pop(context);
              },
              child: Text('Record'),
            ),
          ],
        );
      },
    );
  }

*/










 // New method to calculate next intake time
  String _calculateNextIntakeTime() {
    var now = DateTime.now();
    var nextIntakeTime = now.add(Duration(hours: 2)); // For example, setting the next intake time to 2 hours from now
    return '${nextIntakeTime.hour}:${nextIntakeTime.minute}';
  }

  // New method to determine if it's time for the next intake
  bool _isTimeForNextIntake() {
    var now = DateTime.now();
    var lastIntakeTime = intakeHistory.isNotEmpty ? intakeHistory.last['time'] : DateTime.now();
    var timeSinceLastIntake = now.difference(lastIntakeTime);

    // For example, check if it's been 2 hours since the last intake
    return timeSinceLastIntake.inHours >= 2;
  }

  // New method to show a reminder dialog for the next intake
  void _showNextIntakeReminderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stay Hydrated!'),
          content: Text('It\'s time for your next water intake.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
