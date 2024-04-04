import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/models/point.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:vector_math/vector_math.dart' as v;

class WorldRenderer extends StatefulWidget {
  final List<v.Vector3> points;
  const WorldRenderer({super.key, required this.points});

  @override
  State<WorldRenderer> createState() => _WorldRendererState();
}

class _WorldRendererState extends State<WorldRenderer> {
  double a = 200; // edge length / 2
  late v.Vector3 eye;
  @override
  void initState() {
    super.initState();
    eye = v.Vector3(0, 0, 4 * a);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          eye = v.Vector3(
              (MediaQuery.of(context).size.width / 2 - event.position.dx),
              (MediaQuery.of(context).size.height / 2 - event.position.dy),
              4 * a);
          //TODO: tilt the normal here
        });
      },
      child: CustomPaint(
        painter: _WorldPainter(widget.points, eye),
      ),
    );
  }
}

class _WorldPainter extends CustomPainter {
  final List<v.Vector3> points;
  final v.Vector3 eye;
  const _WorldPainter(this.points, this.eye);

  @override
  void paint(Canvas canvas, Size size) {
    double a = 200; // edge length / 2
    final normal = v.Vector3(0, 0, -a);
    final x = v.Vector3(1, 0, 0);
    final world = World(eye: eye, normal: normal, x: x);
    final List<v.Vector2?> projectedPoints = [];
    for (var point in points) {
      projectedPoints
          .add(world.renderPoint(canvas, Point(position: point), size));
    }
    drawline(canvas, size, projectedPoints[0]!, projectedPoints[1]!);
    drawline(canvas, size, projectedPoints[1]!, projectedPoints[2]!);
    drawline(canvas, size, projectedPoints[2]!, projectedPoints[3]!);
    drawline(canvas, size, projectedPoints[3]!, projectedPoints[0]!);
    drawline(canvas, size, projectedPoints[4]!, projectedPoints[5]!);
    drawline(canvas, size, projectedPoints[5]!, projectedPoints[6]!);
    drawline(canvas, size, projectedPoints[6]!, projectedPoints[7]!);
    drawline(canvas, size, projectedPoints[7]!, projectedPoints[4]!);
    drawline(canvas, size, projectedPoints[0]!, projectedPoints[4]!);
    drawline(canvas, size, projectedPoints[1]!, projectedPoints[5]!);
    drawline(canvas, size, projectedPoints[2]!, projectedPoints[6]!);
    drawline(canvas, size, projectedPoints[3]!, projectedPoints[7]!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawline(Canvas canvas, Size size, v.Vector2 projectedPoint,
      v.Vector2 projectedPoint2) {
    final paint = Paint()..color = Colors.white;
    canvas.drawLine(
      Offset(projectedPoint.x + size.width / 2,
          projectedPoint.y + size.height / 2),
      Offset(projectedPoint2.x + size.width / 2,
          projectedPoint2.y + size.height / 2),
      paint,
    );
  }
}
