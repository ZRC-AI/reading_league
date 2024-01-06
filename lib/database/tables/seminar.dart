import 'package:drift/drift.dart';

@DataClassName('Seminar')
class Seminars extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get initiator => text()();
  TextColumn get description => text()();
}
