import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/cube_template.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:portfolio/3d_Renderer/widgets/renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

const double a = 200;
const double sensitivity = 0.2;

class CubeTest extends StatefulWidget {
  const CubeTest({super.key});

  @override
  State<CubeTest> createState() => _CubeTestState();
}

class _CubeTestState extends State<CubeTest> {
  late final RendererController _controller;
  List<v.Vector3> velocities = [];

  Future<void> _update() async {
    await Future.delayed(const Duration(milliseconds: 1000 ~/ 60));
    _controller.refreshScreen();
    _update();
  }

  @override
  void initState() {
    super.initState();
    _controller = RendererController(
      world: World(
        eye: v.Vector3(0, 0, 4 * a),
        normal: v.Vector3(0, 0, -a),
        x: v.Vector3(1, 0, 0),
      ),
      points: CubeTemplate(edgeLength: 400, center: v.Vector3.zero()).points
        // [
        ..addAll(List.generate(1000, (index) {
          const width = 1000;
          const height = 1000;
          const depth = 1000;
          return v.Vector3(
            width / 2 - Random().nextDouble() * width,
            height / 2 - Random().nextDouble() * height,
            200 - Random().nextDouble() * depth,
          );
        })),
      onInit: () {
        // const double minDistance = 200;
        // _controller.lines = [];
        // for (var i = 0; i < _controller.points.length; i++) {
        //   for (var j = i + 1; j < _controller.points.length; j++) {
        //     final distance =
        //         (_controller.points[i].distanceTo(_controller.points[j])).abs();
        //     if (distance < minDistance) {
        //       final opacity = 1 - (distance / minDistance);
        //       _controller.lines
        //           .add(Line(i, j, Colors.white.withOpacity(opacity)));
        //     }
        //   }
        // }
      },
      lines: CubeTemplate().lines,
      onUpdate: (canvas, size, timeDelta) {
        // if (velocities.isEmpty) {
        //   velocities.addAll(List.generate(_controller.points.length, (index) {
        //     return v.Vector3(
        //       Random().nextDouble() * 1,
        //       Random().nextDouble() * 1,
        //       Random().nextDouble() * 1,
        //     );
        //   }));
        // }
        // const margin = 10000;
        // for (int i = 0; i < _controller.points.length; i++) {
        //   _controller.points[i] +=
        //       velocities[i] * timeDelta.inMilliseconds.toDouble();
        //   if (_controller.points[i].x > margin ||
        //       _controller.points[i].x < -margin) {
        //     velocities[i] =
        //         v.Vector3(-velocities[i].x, velocities[i].y, velocities[i].z);
        //   }
        //   if (_controller.points[i].y > margin ||
        //       _controller.points[i].y < -margin) {
        //     velocities[i] =
        //         v.Vector3(velocities[i].x, -velocities[i].y, velocities[i].z);
        //   }
        //   if (_controller.points[i].z > margin ||
        //       _controller.points[i].z < -margin) {
        //     velocities[i] =
        //         v.Vector3(velocities[i].x, velocities[i].y, -velocities[i].z);
        //   }
        // }
        // _controller.refreshScreen();
        // const double minDistance = 200;
        // _controller.lines = [];
        // for (var i = 0; i < _controller.points.length; i++) {
        //   for (var j = i + 1; j < _controller.points.length; j++) {
        //     final distance =
        //         (_controller.points[i].distanceTo(_controller.points[j])).abs();
        //     if (distance < minDistance) {
        //       final opacity = 1 - (distance / minDistance);
        //       _controller.lines
        //           .add(Line(i, j, Colors.white.withOpacity(opacity)));
        //     }
        //   }
        // }
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
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
          final theta1 = acos(eye.x / r);
          const theta = 1 / 2 * pi;
          // _controller.world.eye = v.Vector3(
          //     r * cos(theta1 + theta), eye.y, r * sin(theta1 + theta));
          // _controller.world.eye = v.Vector3(eye.x + r * sin(theta), eye.y,
          //     eye.z + r * sin(theta) * tan(theta));
          _controller.world.eye = v.Vector3(
              (MediaQuery.of(context).size.width / 2 - event.position.dx),
              (MediaQuery.of(context).size.height / 2 - event.position.dy),
              4 * a);
          _controller.world.normal = v.Vector3(
              -a * sensitivity * (width / 2 - event.position.dx) / (width / 2),
              -a *
                  sensitivity *
                  (height / 2 - event.position.dy) /
                  (height / 2),
              -a);
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
