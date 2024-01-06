import 'dart:ui';

import 'package:drift/drift.dart';

import 'dart:convert';

@DataClassName('PaintPath')
class PaintPaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get description => text()();
  TextColumn get paths => text().map(const PathsConverter()).nullable()();
}

class Paths {
  List<Offset> paths;
  Paths(this.paths);
  factory Paths.fromJson(Map<String, dynamic> json) {
    final List<List<dynamic>> pathListDynamic =
        List<List<dynamic>>.from(json['paths']);
    final List<List<double>> pathList = pathListDynamic
        .map(
          (e) => [e[0] as double, e[1] as double],
        )
        .toList();
    final List<Offset> offsetList =
        pathList.map((e) => Offset(e[0], e[1])).toList();
    return Paths(offsetList);
  }

  Map<String, dynamic> toJson() {
    final List<List<double>> pathList = paths.map((e) => [e.dx, e.dy]).toList();
    return {'paths': pathList};
  }
}

class PathsConverter extends TypeConverter<Paths, String> {
  const PathsConverter();
  @override
  Paths fromSql(String fromDb) {
    return Paths.fromJson(json.decode(fromDb));
  }

  @override
  String toSql(Paths value) {
    return json.encode(value.toJson());
  }
}
