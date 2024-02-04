import 'package:flutter/material.dart';
import 'package:portfolio/moving_dots/models/dot.dart';

class MovingDots extends StatefulWidget {
  final double density;
  final double margin;
  const MovingDots({super.key, this.density = 0.2, this.margin = 200});

  @override
  State<MovingDots> createState() => _MovingDotsState();
}

class _MovingDotsState extends State<MovingDots> {
  final List<Dot> dots = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      double area = height * width;
      dots.addAll(
        List.generate(
          (area * widget.density) ~/ 1000,
          (index) => Dot.random(
            Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
          ),
        ),
      );
      _update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MovingDotsPainter(dots, widget.margin),
    );
  }

  void _updatePositions(double timeDelta) {
    for (var dot in dots) {
      dot.update(timeDelta);
    }
  }

  void _update() {
    const fps = 15;
    const timeDelta = 1 / fps;
    _updatePositions(timeDelta);
    setState(() {});
    Future.delayed(Duration(milliseconds: (1000 * timeDelta).toInt()), _update);
  }
}

class _MovingDotsPainter extends CustomPainter {
  final List<Dot> dots;
  final double margin;
  _MovingDotsPainter(this.dots, this.margin);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    // Drawing Points
    for (var dot in dots) {
      dot.render(canvas, size, margin);
    }
    // Drawing Lines
    final minDistance = margin;
    for (var i = 0; i < dots.length; i++) {
      for (var j = i + 1; j < dots.length; j++) {
        final distance = (dots[i].position - dots[j].position).distance.abs();
        if (distance < minDistance) {
          final opacity = 1 - (distance / minDistance);
          final paint = Paint()
            ..color = Colors.white.withOpacity(opacity)
            ..strokeWidth = 1;
          canvas.drawLine(dots[i].position, dots[j].position, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
