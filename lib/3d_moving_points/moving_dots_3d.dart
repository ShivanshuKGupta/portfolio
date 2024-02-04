import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/3d_moving_points/world_renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

class MovingDots3D extends StatefulWidget {
  final Widget child;
  const MovingDots3D({super.key, required this.child});

  @override
  State<MovingDots3D> createState() => _MovingDots3DState();
}

class _MovingDots3DState extends State<MovingDots3D> {
  final List<v.Vector3> spheres = [];

  @override
  void initState() {
    super.initState();
    double a = 200;
    spheres.insertAll(0, [
      v.Vector3(a, a, a),
      v.Vector3(a, -a, a),
      v.Vector3(-a, -a, a),
      v.Vector3(-a, a, a),
      v.Vector3(a, a, -a),
      v.Vector3(a, -a, -a),
      v.Vector3(-a, -a, -a),
      v.Vector3(-a, a, -a),
    ]);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      // _update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: WorldRenderer(points: spheres),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }

  Future<void> _update() async {
    const fps = kDebugMode ? 0 : 15;
    const timeDelta = 1 / fps;
    _updatePositions(timeDelta);
    setState(() {});
    await Future.delayed(Duration(milliseconds: (1000 * timeDelta).toInt()));
    _update();
  }

  Future<void> _updatePositions(double timeDelta) async {
    for (var point in spheres) {
      point.x += 100 * timeDelta;
      point.y += 100 * timeDelta;
      point.z += 100 * timeDelta;
    }
  }
}
