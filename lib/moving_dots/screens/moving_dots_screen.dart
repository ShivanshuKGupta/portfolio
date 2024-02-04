import 'package:flutter/material.dart';
import 'package:portfolio/moving_dots/widgets/moving_dots.dart';

class MovingDotsScreen extends StatelessWidget {
  final Widget child;
  const MovingDotsScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(
            child: MovingDots(margin: 100, density: 0.2),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
