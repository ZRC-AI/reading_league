import 'package:drift/drift.dart';

@DataClassName('ReferencePath')
class ReferencePaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get referencepath => text()();
}
