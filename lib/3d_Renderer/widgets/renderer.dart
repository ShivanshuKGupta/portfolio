import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:vector_math/vector_math.dart' as v;

class Renderer extends StatefulWidget {
  final RendererController controller;
  final Widget? child;
  final Size? size;

  const Renderer({
    super.key,
    required this.controller,
    this.child,
    this.size,
  });

  @override
  State<Renderer> createState() => _RendererState();
}

class _RendererState extends State<Renderer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.addListener(onRefresh);
      widget.controller.onInit?.call();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(onRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(widget.controller),
      size: widget.size ?? Size.zero,
      child: widget.child,
    );
  }

  void onRefresh() {
    setState(() {});
  }
}

class _Painter extends CustomPainter {
  final RendererController controller;
  _Painter(this.controller);
  DateTime lastTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    // Calculating the next frame content
    final now = DateTime.now();
    controller.beforeUpdate?.call(canvas, size, now.difference(lastTime));
    lastTime = now;

    final List<v.Vector2?> projectedPoints = [];
    // Rendering the points onto the screen
    for (var point in controller.points) {
      projectedPoints.add(controller.world.renderPoint(canvas, point, size));
    }
    // Rendering the lines onto the screen
    for (var line in controller.lines) {
      final start = projectedPoints[line.start];
      final end = projectedPoints[line.end];
      if (start == null || end == null) continue;
      controller.world.renderLine(canvas, start, end, size, line.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //  This is in place to just make sure to only to repaint
    //  when controller.refresh is called, not every time setState is called
    if (controller.drawNextFrame) {
      //  If this is the first refresh then we don't want to refresh again
      //  after refreshing this time.
      controller.drawNextFrame = false;
      return true;
    }
    return false;
  }
}
