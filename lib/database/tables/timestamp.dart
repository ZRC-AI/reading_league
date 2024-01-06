import 'package:drift/drift.dart';

@DataClassName('TimeStamp')
class TimeStamps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get ttaudiopath => text()();
  TextColumn get description => text()();
  RealColumn get dx => real()();
  RealColumn get dy => real()();
  IntColumn get stamp => integer()();
}
