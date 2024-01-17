import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'history_screen.dart'; // Import the HistoryScreen
import 'water_progress.dart'; // Import the WaterProgressPainter

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

    // Start a timer to change the message every 5 seconds
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
        title: Text('Welcome back!'),
        toolbarHeight: 70.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: _buildWelcomeCard(),
            ),
          ),
          _buildWaterProgress(percentage),
          _buildWaterInfo(percentage),
          _buildButtons(),
          _buildIntakeHistoryCard(),
        ],
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
    // Handle navigation
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HistoryScreen()),
      );
    } else if (index == 2) {
      // Use _animationController.animateTo to smoothly animate to the Settings tab
      _animationController.animateTo(2);
    }
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          welcomeMessages[currentMessageIndex],
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInfoColumn(Icons.local_drink, 'Should Take', (percentage * targetWater).toInt().toString() + 'ml'),
          SizedBox(width: 40.0),
          _buildInfoColumn(Icons.local_bar, 'Water Intake', currentIntake.toInt().toString() + 'ml'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _showIntakeConfirmationDialog(),
          child: Text('Confirm Intake'),
        ),
        SizedBox(width: 20.0),
        IconButton(
          icon: Icon(Icons.history),
          onPressed: () => _showTodayIntakeHistoryDialog(),
          tooltip: "Today's Intake History",
        ),
        SizedBox(width: 20.0),
        ElevatedButton(
          onPressed: () => _recordIntakeManually(),
          child: Text('Record Manually'),
        ),
      ],
    );
  }

  Widget _buildIntakeHistoryCard() {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Today's Intake History",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            if (intakeHistory.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: intakeHistory.length,
                itemBuilder: (context, index) {
                  var entry = intakeHistory[index];
                  return ListTile(
                    title: Text('Intake: ${entry['intake'].toInt()}ml'),
                    subtitle: Text('Time: ${entry['time']}'),
                  );
                },
              )
            else
              Text('No intake recorded yet.'),
          ],
        ),
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
                setState(() {
                  consumedWater += currentIntake;
                  intakeHistory.add({
                    'label': 'Confirmed Intake',
                    'intake': currentIntake,
                    'time': _getCurrentTime(),
                  });
                  currentIntake = 0.0;
                });
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
                if (controller.text.isNotEmpty) {
                  double manuallyRecordedIntake = double.parse(controller.text);
                  setState(() {
                    consumedWater += manuallyRecordedIntake;
                    intakeHistory.add({
                      'label': 'Manually Recorded',
                      'intake': manuallyRecordedIntake,
                      'time': _getCurrentTime(),
                    });
                  });
                }
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

  String _getCurrentTime() {
    var now = DateTime.now();
    return '${now.hour}:${now.minute}';
  }

  void _changeWelcomeMessage() {
    setState(() {
      // Change the welcome message to the next one
      currentMessageIndex = (currentMessageIndex + 1) % welcomeMessages.length;
    });
  }
}
