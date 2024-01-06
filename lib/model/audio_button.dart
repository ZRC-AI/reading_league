import 'dart:ui';

import 'package:reading_league/database/database.dart';

class AudioButton {
  int id;
  String name;
  Offset position;
  String seminar;
  String description;
  Duration stamp;
  AudioButton(
      {required this.name,
      required this.position,
      required this.id,
      required this.description,
      required this.stamp,
      required this.seminar});

  factory AudioButton.fromData(TimeStamp data) {
    return AudioButton(
        id: data.id,
        name: data.ttaudiopath,
        position: Offset(data.dx, data.dy),
        description: data.description,
        stamp: Duration(seconds: data.stamp),
        seminar: data.seminar);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'seminar': seminar,
      'position': [position.dx, position.dy],
      'description': description,
      'stamp': stamp.inSeconds,
    };
  }
}
