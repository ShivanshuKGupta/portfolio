import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/vector2_extensions.dart';
import 'package:vector_math/vector_math.dart' as v;

class Renderer extends StatefulWidget {
  final RendererController controller;

  const Renderer({
    super.key,
    required this.controller,
  });

  @override
  State<Renderer> createState() => _RendererState();
}

class _RendererState extends State<Renderer> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onRefresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _Painter(widget.controller, shouldRefresh: true));
  }

  void onRefresh() {
    setState(() {});
  }
}

class _Painter extends CustomPainter {
  bool shouldRefresh;
  final RendererController controller;
  _Painter(this.controller, {this.shouldRefresh = true});

  @override
  void paint(Canvas canvas, Size size) {
    final List<v.Vector2> projectedPoints = [];
    // Rendering the points onto the screen
    for (var point in controller.points) {
      projectedPoints.add(controller.world.renderPoint(canvas, point, size));
    }
    // Rendering the lines onto the screen
    for (var line in controller.lines) {
      final start = projectedPoints[line.start];
      final end = projectedPoints[line.end];
      canvas.drawLine(
          start.toOffset(), end.toOffset(), Paint()..color = line.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //  This is in place to just make sure to only to repaint
    //  when controller.refresh is called
    if (shouldRefresh) {
      //  If this is the first refresh then we don't want to refresh again
      //  after refreshing this time.
      shouldRefresh = false;
      return true;
    }
    return shouldRefresh;
  }
}
