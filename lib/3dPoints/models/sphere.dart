import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/3dPoints/models/world.dart';

class Sphere {
  Offset position;
  Offset velocity;
  double radius;
  Color color;

  Sphere({
    required this.position,
    required this.velocity,
    required this.radius,
    this.color = Colors.white,
  });

  Sphere.random(Size size)
      : position = Offset(
          size.width * math.Random().nextDouble(),
          size.height * math.Random().nextDouble(),
        ),
        velocity = Offset(
          20 * math.Random().nextDouble() - 10,
          20 * math.Random().nextDouble() - 10,
        ),
        color = Colors.white,
        radius = math.Random().nextDouble() * 10 + 1;

  void update(double timeDelta) {
    position += velocity * timeDelta;
  }

  void render(Canvas canvas, Size size, World world) {
    final paint = Paint()..color = color;
    fixPosition(size);
    canvas.drawCircle(position, radius, paint);
  }

  void fixPosition(Size size) {
    if (position.dx < 0) {
      position = Offset(size.width, position.dy);
    } else if (position.dx > size.width) {
      position = Offset(0, position.dy);
    } else if (position.dy < 0) {
      position = Offset(position.dx, size.height);
    } else if (position.dy > size.height) {
      position = Offset(position.dx, 0);
    }
  }
}
