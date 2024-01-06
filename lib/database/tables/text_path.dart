import 'package:drift/drift.dart';

@DataClassName('TextPath')
class TextPaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get textpath => text()();
}
