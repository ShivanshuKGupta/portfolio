import 'package:flutter/material.dart';

class Line {
  final int start;
  final int end;
  final Color color;

  Line({
    required this.start,
    required this.end,
    this.color = Colors.white,
  });
}
