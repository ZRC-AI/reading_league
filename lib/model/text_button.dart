import 'dart:ui';

class TextButtonModel {
  int id;
  String path;
  String name;
  Offset position;
  String seminar;
  TextButtonModel(
      {required this.name,
      required this.path,
      required this.position,
      required this.id,
      required this.seminar});

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'seminar': seminar,
      'position': [position.dx, position.dy],
    };
  }
}
