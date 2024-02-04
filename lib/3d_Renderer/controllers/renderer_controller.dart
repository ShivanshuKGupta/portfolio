import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/models/line.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:vector_math/vector_math.dart' as v;

class RendererController {
  final ValueNotifier<String> _notifier = ValueNotifier('');
  // The setup of the world
  late World world;
  // The points to render
  late List<v.Vector3> points;
  // The lines to render
  List<Line> lines = [];

  RendererController({
    required this.world,
    required this.points,
    List<Line>? lines,
  }) {
    this.lines = lines ?? this.lines;
  }

  // Refresh the renderer, drwaing new points and lines onto the renderer
  void refresh() {
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

  void dispose() {
    _notifier.dispose();
  }
}
