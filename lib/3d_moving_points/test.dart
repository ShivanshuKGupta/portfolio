import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/cube_template.dart';
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
    _controller = RendererController(
      world: World(
        eye: v.Vector3(0, 0, 4 * 200),
        normal: v.Vector3(0, 0, -200),
        x: v.Vector3(1, 0, 0),
      ),
      points: CubeTemplate(edgeLength: 400).points,
      onInit: () {
        // add points here randomly
        _controller.points.addAll(List.generate(100, (index) {
          return v.Vector3(
            index * 10,
            index * 10,
            -index * 10,
          );
        }));
      },
      onUpdate: (canvas, size, timeDelta) {
        // move the points here
        for (var point in _controller.points) {
          point.x += 1;
          point.y += 1;
          point.z -= -1;
        }
      },
    );
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
              4 * 200);
          _controller.world.normal = v.Vector3(
              -200 * 0.2 * (width / 2 - event.position.dx) / (width / 2),
              -200 * 0.2 * (height / 2 - event.position.dy) / (height / 2),
              -200);
          // _controller.refreshScreen();
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
