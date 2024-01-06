import 'dart:ui';

class Paintpaths {
  int id;
  String description;
  List<Offset> paths;
  String seminar;

  Paintpaths(
      {required this.description,
      required this.paths,
      required this.id,
      required this.seminar});

  Map<String, dynamic> toJson() {
    return {
      'seminar': seminar,
      'paths': paths.map((offset) => [offset.dx, offset.dy]).toList(),
      'description': description,
    };
  }
}
