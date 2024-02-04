import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/line.dart';
import 'package:portfolio/3d_Renderer/models/vector2_extensions.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:vector_math/vector_math.dart' as v;

class Renderer extends StatefulWidget {
  final World world;
  final List<v.Vector3> points;
  final List<Line> lines;
  final RendererController? controller;
  const Renderer({
    super.key,
    required this.world,
    required this.points,
    required this.lines,
    this.controller,
  });

  @override
  State<Renderer> createState() => _RendererState();
}

class _RendererState extends State<Renderer> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(onRefresh);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(onRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(widget),
    );
  }

  void onRefresh() {
    setState(() {});
  }
}

class _Painter extends CustomPainter {
  bool refresh;
  final Renderer renderer;
  _Painter(this.renderer, {this.refresh = true});

  @override
  void paint(Canvas canvas, Size size) {
    final List<v.Vector2> projectedPoints = [];
    for (var point in renderer.points) {
      projectedPoints.add(renderer.world.renderPoint(canvas, point, size));
    }
    for (var line in renderer.lines) {
      final start = projectedPoints[line.start];
      final end = projectedPoints[line.end];
      canvas.drawLine(
          start.toOffset(), end.toOffset(), Paint()..color = line.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (refresh) {
      refresh = false;
      return true;
    }
    return refresh;
  }
}
