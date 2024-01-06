import 'package:drift/drift.dart';

@DataClassName('ReferenceButton')
class ReferenceButtons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get referencepath => text()();
  TextColumn get description => text()();
  RealColumn get dx => real()();
  RealColumn get dy => real()();
}
