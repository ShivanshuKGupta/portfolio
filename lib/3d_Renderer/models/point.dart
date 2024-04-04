import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as v;

class Point {
  v.Vector3 position;

  double get x => position.x;
  double get y => position.y;
  double get z => position.z;
  set x(double value) => position.x = value;
  set y(double value) => position.y = value;
  set z(double value) => position.z = value;

  v.Vector3? velocity;
  Color color;
  double radius;

  Point({
    required this.position,
    this.velocity,
    this.color = Colors.white,
    this.radius = 1,
  });

  void updatePosition(Duration timeDelta) {
    if (velocity != null) {
      position += velocity! * timeDelta.inMilliseconds.toDouble();
    }
  }
}
