import 'package:flutter/material.dart' as material;
import 'package:portfolio/3d_Renderer/models/point.dart';
import 'package:portfolio/3d_Renderer/models/vector2_extensions.dart';
import 'package:vector_math/vector_math.dart';

class World {
  // The position of eye in 3d space.
  Vector3 eye;
  // The vector in between eye and the mid point of the screen.
  Vector3 normal;
  // unit vector pointing towards the +ve x-axis of the screen.
  Vector3 x;
  // unit vector pointing towards the +ve y-axis of the screen.
  late Vector3 y;
  // The MidPoint of the screen
  late Vector3 M;

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
  Vector2? projectPoint(Vector3 point) {
    final ep = point - eye;
    final r = (normal.length * normal.length * ep.length / ep.dot(normal));
    final eq = ep * r / ep.length;
    if (ep.dot(normal) < 0) {
      return null; // The point is behind the screen
    }
    final mq = eq - normal;
    final projectedPoint = Vector2(mq.dot(x), mq.dot(y));
    return projectedPoint;
  }

  // Renders a 3d point onto the 2d canvas
  Vector2? renderPoint(
      material.Canvas canvas, Point point, material.Size size) {
    final projectedPoint = projectPoint(point.position);
    if (projectedPoint == null) return null;
    final ep = point.position - eye;
    final paint = material.Paint()..color = point.color;
    canvas.drawCircle(
      material.Offset(projectedPoint.x + size.width / 2,
          projectedPoint.y + size.height / 2),
      2000 / ep.length + point.radius,
      paint,
    );
    return projectedPoint;
  }

  void renderLine(
      material.Canvas canvas, Vector2 start, Vector2 end, material.Size size,
      [material.Color? color]) {
    canvas.drawLine(
      start.toOffset() + material.Offset(size.width / 2, size.height / 2),
      end.toOffset() + material.Offset(size.width / 2, size.height / 2),
      material.Paint()..color = color ?? material.Colors.white,
    );
  }
}
