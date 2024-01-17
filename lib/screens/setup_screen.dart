import 'package:flutter/material.dart';
import 'weight_module.dart'; // Import the WeightModule screen

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGenderOption(
                    context,
                    'Male',
                    Icons.male,
                    Colors.blue,
                    () => _onGenderSelected(context, 'Male'),
                  ),
                  SizedBox(width: 20.0),
                  _buildGenderOption(
                    context,
                    'Female',
                    Icons.female,
                    Colors.pink,
                    () => _onGenderSelected(context, 'Female'),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Text(
      'Welcome! Let\'s set up your profile.',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGenderOption(
    BuildContext context,
    String gender,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedGender = gender;
        });
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: selectedGender == gender ? Colors.grey : color,
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 80.0,
            color: Colors.white,
          ),
          SizedBox(height: 10.0),
          Text(
            gender,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the WeightModule screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WeightModule()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  void _onGenderSelected(BuildContext context, String selectedGender) {
    // TODO: Implement logic to handle the selected gender.
    print('Selected gender: $selectedGender');
  }
}
