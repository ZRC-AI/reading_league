import 'package:drift/drift.dart';

@DataClassName('PdfPath')
class PdfPaths extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seminar => text()();
  TextColumn get pdfpath => text()();
}
