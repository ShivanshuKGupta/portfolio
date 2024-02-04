import 'package:flutter/material.dart';
import 'package:portfolio/3d_Renderer/controllers/renderer_controller.dart';
import 'package:portfolio/3d_Renderer/models/cube_template.dart';
import 'package:portfolio/3d_Renderer/models/world.dart';
import 'package:portfolio/3d_Renderer/widgets/renderer.dart';
import 'package:vector_math/vector_math.dart' as v;

const double a = 200;
const double sensitivity = 0.2;

class CubeTest extends StatelessWidget {
  CubeTest({super.key});
  final RendererController _controller = RendererController(
    world: World(
      eye: v.Vector3(0, 0, 4 * a),
      normal: v.Vector3(0, 0, -a),
      x: v.Vector3(1, 0, 0),
    ),
    points: CubeTemplate(edgeLength: 200, center: v.Vector3.zero()).points,
    lines: CubeTemplate().lines,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
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
