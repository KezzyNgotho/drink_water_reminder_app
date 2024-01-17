import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'setup_screen.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Started'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWaterDrop(),
            SizedBox(height: 20.0),
            _buildAnimatedDescription(),
            SizedBox(height: 40.0),
            _buildGetStartedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterDrop() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.waves,
        color: Colors.white,
        size: 120.0,
      ),
    );
  }

  Widget _buildAnimatedDescription() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Welcome to WaterApp', speed: Duration(milliseconds: 100)),
            WavyAnimatedText('Stay hydrated and healthy!', speed: Duration(milliseconds: 100)),
          ],
          isRepeatingAnimation: true,
          totalRepeatCount: 3,
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetupScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          'Get Started',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
