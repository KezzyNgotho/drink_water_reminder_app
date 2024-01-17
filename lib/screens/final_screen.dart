import 'package:flutter/material.dart';
import 'home_screen.dart';

class FinalScreen extends StatefulWidget {
  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Set up the wave animation
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hey there !'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeMessage(),
              SizedBox(height: 20.0),
              _buildWaterAnimation(),
              SizedBox(height: 40.0),
              _buildFinishSetupButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
  return Text(
    'Congratulations!\nYou\'ve completed the setup.',
    style: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    textAlign: TextAlign.center,
  );
}


  Widget _buildWaterAnimation() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return ClipPath(
            clipper: WaveClipper(_waveAnimation.value),
            child: Container(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _buildFinishSetupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      },
      child: Text('Finish Setup'),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    final midPoint = size.height * 0.8;

    path.lineTo(0, midPoint);

    for (int i = 0; i < size.width.toInt(); i++) {
      double waveHeight = 20.0 * animationValue;
      path.lineTo(i.toDouble(), midPoint + waveHeight);
    }

    path.lineTo(size.width, midPoint);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

