import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:portfolio/3d_Renderer/widgets/renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

const double a = 200;

class Test extends StatelessWidget {
  Test({super.key});
  final RendererController _controller = RendererController(
    world: World(
      eye: v.Vector3(0, 0, 4 * a),
      normal: v.Vector3(0, 0, -a),
      x: v.Vector3(0, 1, 0),
    ),
    points: [
      v.Vector3(a, a, a),
      v.Vector3(a, -a, a),
      v.Vector3(-a, -a, a),
      v.Vector3(-a, a, a),
      v.Vector3(a, a, -a),
      v.Vector3(a, -a, -a),
      v.Vector3(-a, -a, -a),
      v.Vector3(-a, a, -a),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          _controller.world.eye = v.Vector3(
              (MediaQuery.of(context).size.width / 2 - event.position.dx),
              (MediaQuery.of(context).size.height / 2 - event.position.dy),
              4 * a);
          log("eye: ${_controller.world.eye}");
          _controller.refresh();
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
