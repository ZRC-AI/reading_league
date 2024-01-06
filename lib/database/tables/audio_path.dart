import 'package:drift/drift.dart';

@DataClassName('AudioPath')
class AudioPaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get audiopath => text()();
}
