import 'package:drift/drift.dart';

@DataClassName('ImagePath')
class ImagePaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get imagepath => text()();
}
