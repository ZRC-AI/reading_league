import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'tables/seminar.dart';
import './tables/audio_path.dart';
import 'tables/text_path.dart';
import './tables/image_path.dart';
import './tables/pdf_path.dart';
import 'tables/timestamp.dart';

import './tables/text_button.dart';
import './tables/paint_path.dart';
import './tables/reference.dart';
import './tables/reference_button.dart';
part 'database.g.dart';

@DriftDatabase(tables: [
  Seminars,
  AudioPaths,
  TextPaths,
  ImagePaths,
  PdfPaths,
  TimeStamps,
  TextButtons,
  PaintPaths,
  ReferencePaths,
  ReferenceButtons,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'databases', 'database12.db'));
    // return NativeDatabase(file);
    Logger().d(dbFolder);
    return NativeDatabase.createInBackground(file);
  });
}
