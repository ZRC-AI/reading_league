import 'dart:ui';

class ReferenceButtonModel {
  int id;
  String name;
  Offset position;
  String seminar;
  String description;
  ReferenceButtonModel(
      {required this.name,
      required this.position,
      required this.id,
      required this.seminar,
      required this.description});

  // factory TextButton.fromData(db.TextButton data) {
  //   return TextButton(
  //       id: data.id,
  //       name: data.ttaudiopath,
  //       position: Offset(data.dx, data.dy),
  //       description: data.description,
  //       stamp: Duration(seconds: data.stamp),
  //       seminar: data.seminar);
  // }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'seminar': seminar,
      'position': [position.dx, position.dy],
      'description': description,
    };
  }
}
