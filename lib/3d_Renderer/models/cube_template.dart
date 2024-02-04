import 'package:portfolio/3d_Renderer/models/line.dart';
import 'package:vector_math/vector_math.dart' as v;

class CubeTemplate {
  final double edgeLength;
  final v.Vector3 center;
  CubeTemplate({this.edgeLength = 200.0, v.Vector3? center})
      : center = center ?? v.Vector3.zero();

  List<Line> get lines {
    return [
      Line(0, 1),
      Line(1, 2),
      Line(2, 3),
      Line(3, 0),
      Line(4, 5),
      Line(5, 6),
      Line(6, 7),
      Line(7, 4),
      Line(0, 4),
      Line(1, 5),
      Line(2, 6),
      Line(3, 7),
    ];
  }

  List<v.Vector3> get points {
    return [
      v.Vector3(
          center.x + edgeLength, center.y + edgeLength, center.z + edgeLength),
      v.Vector3(
          center.x + edgeLength, center.y + -edgeLength, center.z + edgeLength),
      v.Vector3(center.x + -edgeLength, center.y + -edgeLength,
          center.z + edgeLength),
      v.Vector3(
          center.x + -edgeLength, center.y + edgeLength, center.z + edgeLength),
      v.Vector3(
          center.x + edgeLength, center.y + edgeLength, center.z + -edgeLength),
      v.Vector3(center.x + edgeLength, center.y + -edgeLength,
          center.z + -edgeLength),
      v.Vector3(center.x + -edgeLength, center.y + -edgeLength,
          center.z + -edgeLength),
      v.Vector3(center.x + -edgeLength, center.y + edgeLength,
          center.z + -edgeLength),
    ];
  }
}
