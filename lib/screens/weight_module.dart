import 'package:flutter/material.dart';
import 'time_module.dart';

class WeightModule extends StatefulWidget {
  @override
  _WeightModuleState createState() => _WeightModuleState();
}

class _WeightModuleState extends State<WeightModule> {
  double selectedWeight = 60.0; // Default weight

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' What is your Weight'),
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
              _buildWeightSlider(),
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
      'Let\'s set up your profile.\nSelect your weight:',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildWeightSlider() {
    return Column(
      children: [
        Text(
          'Weight: ${selectedWeight.toInt()} kg',
          style: TextStyle(fontSize: 18.0),
        ),
        Slider(
          value: selectedWeight,
          min: 40.0,
          max: 150.0,
          onChanged: (value) {
            setState(() {
              selectedWeight = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the TimeModule screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimeModule()),
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
