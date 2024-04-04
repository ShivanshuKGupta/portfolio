import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/models/line.dart';
import 'package:portfolio/3d_Renderer/models/point.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';

class RendererController {
  final ValueNotifier<String> _notifier = ValueNotifier('');
  // The setup of the world
  late World world;
  // The points to render
  List<Point> points = [];
  // The lines to render
  List<Line> lines = [];

  /// Whether to draw the next frame
  bool drawNextFrame = true;
  // The function which is called before the screen is drawn
  // Use this to calculate the next position of the points
  final void Function(Canvas canvas, Size size, Duration timeDelta)?
      beforeUpdate;

  /// The function which is called when the controller is initialized
  final void Function()? onInit;

  RendererController({
    required this.world,
    List<Point>? points,
    List<Line>? lines,
    this.beforeUpdate,
    this.onInit,
  }) {
    this.lines = lines ?? this.lines;
    this.points = points ?? this.points;
  }

  // Refresh the renderer, drawing new points and lines onto the renderer
  void refreshScreen() {
    drawNextFrame = true;
    _notifier.value = DateTime.now().toString();
  }

  String get value => _notifier.value;
  set value(String v) => _notifier.value = v;

  // Add a listener to the controller
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  // Remove a listener from the controller
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  // Updates position of points based on thier velocity
  void updatePointPositions(Duration timeDelta) {
    for (var point in points) {
      point.updatePosition(timeDelta);
    }
  }
}
