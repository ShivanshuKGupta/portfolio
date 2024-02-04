import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

extension Vector2Extensions on Vector2 {
  Offset toOffset() {
    return Offset(x, y);
  }
}
