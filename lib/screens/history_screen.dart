import 'package:drink_water_reminder/screens/home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drink_water_reminder/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatisticsCard(),
            SizedBox(height: 16.0),
            _buildTipsCard(),
            SizedBox(height: 16.0),
            _buildAdditionalFeatures(),
          ],
        ),
      ),
     bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.history, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          // Handle navigation
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
        index: 1, // Set the initial active item (History)
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
      ),
    );
  }





  Widget _buildStatisticsCard() {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consumption Statistics',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            _buildWeeklyConsumptionChart(),
            _buildStatisticItem('Monthly Consumption', '40,000ml'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyConsumptionChart() {
    return Container(
      height: 200.0,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(showTitles: true),
          ),
          borderData: FlBorderData(show: true),
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 5000),
                FlSpot(1, 8000),
                FlSpot(2, 12000),
                FlSpot(3, 10000),
                FlSpot(4, 15000),
                FlSpot(5, 9000),
                FlSpot(6, 11000),
              ],
              isCurved: true,
              colors: [Colors.blue],
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTipsCard() {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tips for Staying Hydrated',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            _buildTipItem('Tip 1', 'Drink water first thing in the morning.'),
            _buildTipItem('Tip 2', 'Carry a reusable water bottle with you.'),
            _buildTipItem('Tip 3', 'Set reminders to drink water throughout the day.'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(description),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildAdditionalFeatures() {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Features',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            // Add any additional features or settings here.
          ],
        ),
      ),
    );
  }
}
