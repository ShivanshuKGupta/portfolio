import 'dart:math' as math;

import 'package:flutter/material.dart';

class Dot {
  Offset position;
  Offset velocity;
  late double radius;
  Color color;

  Dot({
    required this.position,
    required this.velocity,
    this.color = Colors.white,
  }) : radius = velocity.distance / 10 + 1;

  Dot.random(Size size)
      : position = Offset(
          size.width * math.Random().nextDouble(),
          size.height * math.Random().nextDouble(),
        ),
        velocity = Offset(
          20 * math.Random().nextDouble() - 10,
          20 * math.Random().nextDouble() - 10,
        ),
        color = Colors.white {
    radius = velocity.distance / 10 + 1;
  }

  void update(double timeDelta) {
    position += velocity * timeDelta;
  }

  void render(Canvas canvas, Size size, [double margin = 200]) {
    final paint = Paint()..color = color;
    fixPosition(size, margin);
    canvas.drawCircle(position, radius, paint);
  }

  void fixPosition(Size size, [double margin = 200]) {
    if (position.dx < -margin) {
      position = Offset(size.width, position.dy);
    } else if (position.dx > size.width + margin) {
      position = Offset(0, position.dy);
    } else if (position.dy < -margin) {
      position = Offset(position.dx, size.height);
    } else if (position.dy > size.height + margin) {
      position = Offset(position.dx, 0);
    }
  }
}
