import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/cube_template.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:portfolio/3d_Renderer/widgets/renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

class Test extends StatelessWidget {
  Test({super.key});
  final RendererController _controller = RendererController(
    world: World(
      eye: v.Vector3(0, 0, 4 * 200),
      normal: v.Vector3(0, 0, -200),
      x: v.Vector3(1, 0, 0),
    ),
    points: CubeTemplate(edgeLength: 200, center: v.Vector3.zero()).points,
    lines: CubeTemplate().lines,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Renderer(controller: _controller),
    );
  }
}
