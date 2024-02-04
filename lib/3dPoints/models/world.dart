import 'package:flutter/material.dart' as material;
import 'package:vector_math/vector_math.dart';

class World {
  // The position of eye in 3d space.
  final Vector3 eye;
  // The vector in between eye and the mid point of the screen.
  final Vector3 normal;
  // unit vector pointing towards the +ve x-axis of the screen.
  Vector3 x;
  // unit vector pointing towards the +ve y-axis of the screen.
  late final Vector3 y;
  // The MidPoint of the screen
  late final Vector3 M;

  World({
    required this.eye,
    required this.normal,
    required this.x,
  }) {
    x = x / x.length;
    y = x.cross(normal).normalized();
    M = eye + normal;
  }

  // Projects a 3d point onto the 2d screen
  Vector2 _project(Vector3 point) {
    final ep = point - eye;
    final r = (normal.length * normal.length * ep.length / ep.dot(normal));
    final eq = ep * r / ep.length;
    final mq = eq - normal;
    final projectedPoint = Vector2(mq.dot(x), mq.dot(y));
    return projectedPoint;
  }

  // Renders a 3d point onto the 2d canvas
  Vector2 renderPoint(
      material.Canvas canvas, Vector3 point, material.Size size) {
    final projectedPoint = _project(point);
    final ep = point - eye;
    final paint = material.Paint()..color = material.Colors.white;
    canvas.drawCircle(
      material.Offset(projectedPoint.x + size.width / 2,
          projectedPoint.y + size.height / 2),
      100 / ep.length + 1,
      paint,
    );
    return projectedPoint;
  }
}
