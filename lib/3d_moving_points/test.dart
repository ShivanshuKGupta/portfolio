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
  final List<v.Vector3> points = [];
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
        points.addAll(List.generate(0, (index) {
          return v.Vector3(
            index * 10,
            0,
            -index * 10,
          );
        }));
      },
      onUpdate: (canvas, size, timeDelta) {
        // move the points here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Renderer(
          controller: _controller,
          child: const Center(
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
