import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/cube_template.dart';
import 'package:portfolio/3d_Renderer/models/point.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:portfolio/3d_Renderer/widgets/renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

class MovingDots3dTest extends StatefulWidget {
  const MovingDots3dTest({super.key});

  @override
  State<MovingDots3dTest> createState() => _MovingDots3dTestState();
}

class _MovingDots3dTestState extends State<MovingDots3dTest> {
  late final RendererController _controller;

  @override
  void initState() {
    super.initState();
    double a = 200;
    const double xMargin = 10000;
    const double yMargin = 10000;
    const double zMargin = 10000;
    _controller = RendererController(
      world: World(
        eye: v.Vector3(0, 0, 4 * a),
        normal: v.Vector3(0, 0, -a),
        x: v.Vector3(1, 0, 0),
      ),
      points: CubeTemplate(edgeLength: 2 * a).points,
      lines: CubeTemplate(edgeLength: 2 * a).lines,
      onInit: () {
        _controller.points.addAll(List.generate(1000, (index) {
          return Point(
            position: v.Vector3(
              math.Random().nextDouble() * xMargin - xMargin / 2,
              math.Random().nextDouble() * yMargin - yMargin / 2,
              math.Random().nextDouble() * zMargin - zMargin / 2,
            ),
            velocity: v.Vector3(
              math.Random().nextDouble() * 4 - 2,
              math.Random().nextDouble() * 4 - 2,
              math.Random().nextDouble() * 4 - 2,
            ),
            radius: 1,
            // color: Colors.primaries[index % Colors.primaries.length],
          );
        }));
      },
      beforeUpdate: (canvas, size, timeDelta) {
        _controller.updatePointPositions(const Duration(milliseconds: 1));
        // points which moved out of margin should reappear on the other side
        for (var point in _controller.points) {
          if (point.x > xMargin / 2) {
            point.x = -xMargin / 2;
          } else if (point.x < -xMargin / 2) {
            point.x = xMargin / 2;
          }
          if (point.y > yMargin / 2) {
            point.y = -yMargin / 2;
          } else if (point.y < -yMargin / 2) {
            point.y = yMargin / 2;
          }
          if (point.z > zMargin / 2) {
            point.z = -zMargin / 2;
          } else if (point.z < -zMargin / 2) {
            point.z = zMargin / 2;
          }
        }
      },
    );
    startSimulation();
  }

  void startSimulation() {
    Future.delayed(const Duration(milliseconds: 1000 ~/ 60), () {
      _controller.refreshScreen();
      startSimulation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          const r = 800;
          final eye = _controller.world.eye;
          final theta1 = math.acos(eye.x / r);
          const theta = 1 / 2 * math.pi;
          // _controller.world.eye = v.Vector3(
          //     r * cos(theta1 + theta), eye.y, r * sin(theta1 + theta));
          // _controller.world.eye = v.Vector3(eye.x + r * sin(theta), eye.y,
          //     eye.z + r * sin(theta) * tan(theta));
          _controller.world.eye = v.Vector3(
              (MediaQuery.of(context).size.width / 2 - event.position.dx),
              (MediaQuery.of(context).size.height / 2 - event.position.dy),
              4 * 200);
          _controller.world.normal = v.Vector3(
              -200 * 0.2 * (width / 2 - event.position.dx) / (width / 2),
              -200 * 0.2 * (height / 2 - event.position.dy) / (height / 2),
              -200);
          _controller.refreshScreen();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Renderer(controller: _controller),
        ),
      ),
    );
  }
}
