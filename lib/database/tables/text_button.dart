import 'package:drift/drift.dart';

@DataClassName('TextButton')
class TextButtons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get textpath => text()();
  RealColumn get dx => real()();
  RealColumn get dy => real()();
}
