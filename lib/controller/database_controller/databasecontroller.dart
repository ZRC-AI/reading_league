import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:reading_league/model/audio_button.dart' as ab;
import 'package:reading_league/model/image.dart' as image;
import 'package:reading_league/model/text_button.dart' as tb;
import 'package:reading_league/model/paint_path.dart' as pp;
import 'package:reading_league/model/seminar.dart' as sl;
import '../../model/text.dart' as t;
import 'package:reading_league/model/reference.dart' as r;
import 'package:reading_league/model/reference_button.dart' as rb;
import 'package:reading_league/model/audio.dart' as a;
import 'package:reading_league/model/pdf.dart' as pdf;
import 'package:reading_league/database/tables/paint_path.dart' as tpp;

import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import '../../database/database.dart';

import 'package:path/path.dart' as p;

class DatabaseController extends GetxController {
  final _db = MyDatabase();
  // 初始化数据库和Repository
  Future<void> insertseminar(
    String name,
    String initiator,
    String description,
  ) async {
    try {
      await _db.into(_db.seminars).insert(SeminarsCompanion(
            name: drift.Value(name),
            initiator: drift.Value(initiator),
            description: drift.Value(description),
          ));
      Logger().d('seminar插入成功');
    } catch (e) {
      Logger().d('seminar插入失败："${e}"');
    }
  }

  Future<void> deleteSeminar(sl.SeminarLibrary seminar) async {
    try {
      await _db.transaction(() async {
        await (_db.delete(_db.seminars)
              ..where((t) => t.name.equals(seminar.name)))
            .go();
        await (_db.delete(_db.audioPaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.imagePaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.paintPaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.pdfPaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.timeStamps)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.referenceButtons)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.referencePaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.textButtons)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
        await (_db.delete(_db.textPaths)
              ..where((t) => t.seminar.equals(seminar.name)))
            .go();
      });
      Logger().d('成功');
    } catch (e) {
      Logger().d(' delete error : ${e}');
    }
  }

  Future<void> insertpdf(String seminar, String pdfpath) async {
    try {
      await _db.into(_db.pdfPaths).insert(PdfPathsCompanion(
          seminar: drift.Value(seminar), pdfpath: drift.Value(pdfpath)));
      selectpdf(seminar);
      Logger().d('pdf插入成功');
    } catch (e) {
      Logger().d('pdf插入失败：${e}');
    }
  }

  // Future<void> insert(SeminarLibrary seminarLibrary) async {
  //   _db.transaction(() async {
  //     try {
  //       await _db.into(_db.seminars).insert(SeminarsCompanion.insert(
  //             name: seminarLibrary.name,
  //             initiator: seminarLibrary.initiator,
  //             description: drift.Value(seminarLibrary.description),
  //           ));
  //       if (seminarLibrary.libraries['audios']!.isEmpty) {
  //       } else {
  //         for (String? audiopath in seminarLibrary.libraries['audios']!) {
  //           await _db.into(_db.audioPaths).insert(AudioPathsCompanion(
  //               seminar: drift.Value(seminarLibrary.name),
  //               audiopath: drift.Value(audiopath!)));
  //         }
  //       }

  //       if (seminarLibrary.libraries['pdfs']!.isEmpty) {
  //       } else {
  //         for (String? pdfpath in seminarLibrary.libraries['pdfs']!) {
  //           await _db.into(_db.pdfPaths).insert(PdfPathsCompanion(
  //               seminar: drift.Value(seminarLibrary.name),
  //               pdfpath: drift.Value(pdfpath!)));
  //         }
  //       }

  //       if (seminarLibrary.libraries['txts']!.isEmpty) {
  //       } else {
  //         for (String? txtpath in seminarLibrary.libraries['txts']!) {
  //           await _db.into(_db.textPaths).insert(TextPathsCompanion(
  //               seminar: drift.Value(seminarLibrary.name),
  //               textpath: drift.Value(txtpath!)));
  //         }
  //       }

  //       if (seminarLibrary.libraries['images']!.isEmpty) {
  //       } else {
  //         for (String? imagepath in seminarLibrary.libraries['images']!) {
  //           await _db.into(_db.imagePaths).insert(ImagePathsCompanion(
  //               seminar: drift.Value(seminarLibrary.name),
  //               imagepath: drift.Value(imagepath!)));
  //         }
  //       }

  //       Logger().d('数据插入成功');
  //     } catch (e) {
  //       Logger().d('数据插入失败："${e}"');
  //     }
  //   });
  // }

  Future<void> deleteaudio(a.Audio audio) async {
    await (_db.delete(_db.audioPaths)
          ..where((t) {
            return t.audiopath.equals(audio.path) &
                t.seminar.equals(audio.seminar);
          }))
        .go();
    await (_db.delete(_db.timeStamps)
          ..where((t) =>
              t.ttaudiopath.equals(audio.path) &
              t.seminar.equals(audio.seminar)))
        .go();
  }

  Future<void> insertaudio(String seminar, String audiopath) async {
    try {
      await _db.into(_db.audioPaths).insert(
            AudioPathsCompanion(
                audiopath: drift.Value(audiopath),
                seminar: drift.Value(seminar)),
          );
      Logger().d('音频更新成功');
    } catch (e) {
      Logger().d('音频更新成功："${e}"');
    }
  }

  Future<List<sl.SeminarLibrary>> selectseminar() async {
    try {
      final results = await _db.select(_db.seminars).get();
      List<sl.SeminarLibrary> seminars = [];
      for (var result in results) {
        if (result.description == null) {
          sl.SeminarLibrary s = sl.SeminarLibrary(
              name: result.name,
              initiator: result.initiator,
              description: '这个人很懒，还没有写注释～');
          seminars.add(s);
        } else {
          sl.SeminarLibrary s = sl.SeminarLibrary(
              name: result.name,
              initiator: result.initiator,
              description: result.description!);
          seminars.add(s);
        }
      }

      Logger().d('seminar获取成功:${seminars}');
      return seminars;
    } catch (e) {
      Logger().d('seminar获取失败："${e}"');
      return [];
    }
  }

  Future<List<pdf.Pdf>> selectpdf(String seminarname) async {
    try {
      final results = await _db.select(_db.pdfPaths).get();

      List<pdf.Pdf> pdfpaths = [];
      for (PdfPath path in results) {
        pdfpaths.add(
            pdf.Pdf(id: path.id, seminar: path.seminar, path: path.pdfpath));
      }

      Logger().d('pdf查询成功');
      return pdfpaths;
    } catch (e) {
      Logger().d('pdf查询失败："${e}"');
      return [];
    }
  }

  Future<void> updateaudiopath(
      String seminar, String oldname, String newname) async {
    try {
      await _db.update(_db.audioPaths)
        ..where((t) => t.audiopath.equals(oldname))
        ..write(AudioPathsCompanion(audiopath: drift.Value(newname)));
      await _db.update(_db.timeStamps)
        ..where((t) => t.ttaudiopath.equals(oldname))
        ..write(TimeStampsCompanion(ttaudiopath: drift.Value(newname)));
      Logger().d('音频name更改成功:${newname}');
    } catch (e) {
      Logger().d('音频name更改失败:"${e}"');
    }
  }

  Future<List<a.Audio>> selectaudio(String seminarname) async {
    try {
      final results = await _db.select(_db.audioPaths)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final pathlist = await results.get();
      List<a.Audio> audiopaths = [];
      for (AudioPath result in pathlist) {
        audiopaths.add(a.Audio(
          id: result.id,
          seminar: result.seminar,
          path: result.audiopath,
        ));
      }
      Logger().d('音频获取成功:${audiopaths}');
      return audiopaths;
    } catch (e) {
      Logger().d('音频获取失败："${e}"');
      return [];
    }
  }

  Future<List<ab.AudioButton>> selectaudiobt(String seminar) async {
    try {
      final results = await _db.select(_db.timeStamps)
        ..where((t) => t.seminar.equals(seminar))
        ..get();
      final keyresults = await results.get();
      final audioButtons =
          keyresults.map((e) => ab.AudioButton.fromData(e)).toList();
      Logger().d('音频时间戳获取成功');
      return audioButtons;
    } catch (e) {
      Logger().d('音频时间戳获取失败："${e}"');
      return [];
    }
  }

  Future<void> updateaudiobt(int id, Offset offset) async {
    try {
      await _db.update(_db.timeStamps)
        ..where((t) => t.id.equals(id))
        ..write(TimeStampsCompanion(
            dx: drift.Value(offset.dx), dy: drift.Value(offset.dy)));
      Logger().d('音频时间更新成功');
    } catch (e) {
      Logger().d('音频时间戳更新失败："${e}"');
    }
  }

  Future<void> updatebttime(int id, int shift, int oldstamp) async {
    try {
      int newstamp = oldstamp + shift;
      await _db.update(_db.timeStamps)
        ..where((t) => t.id.equals(id))
        ..write(TimeStampsCompanion(stamp: drift.Value(newstamp)));
      Logger().d('修改时间戳成功');
    } catch (e) {
      Logger().d('修改时间戳失败:${e}');
    }
  }

  Future<void> insertaudiobt(
      {required String seminar,
      required String name,
      required double dx,
      required double dy,
      required int stamp}) async {
    try {
      await _db.into(_db.timeStamps).insert(TimeStampsCompanion(
          seminar: drift.Value(seminar),
          ttaudiopath: drift.Value(name),
          description: drift.Value('description'),
          dx: drift.Value(dx),
          dy: drift.Value(dy),
          stamp: drift.Value(stamp)));

      Logger().d('音频时间戳插入成功');
    } catch (e) {
      Logger().d('音频时间戳插入失败："${e}"');
    }
  }

  Future<void> deleteaudiobt(int id) async {
    try {
      await (_db.delete(_db.timeStamps)..where((tbl) => tbl.id.equals(id)))
          .go();
      Logger().d('音频时间戳删除成功');
    } catch (e) {
      Logger().d('音频时间戳删除失败${e}');
    }
  }

  Future<void> inserttext(String textpath, String seminar) async {
    try {
      await _db.into(_db.textPaths).insert(
            TextPathsCompanion(
                textpath: drift.Value(textpath), seminar: drift.Value(seminar)),
          );
      Logger().d('text更新成功');
    } catch (e) {
      Logger().d('text更新失败："${e}"');
    }
  }

  Future<void> updatetextpath(t.Text text, String newname) async {
    try {
      await _db.update(_db.textPaths)
        ..where((t) => t.textpath.equals(text.path))
        ..write(TextPathsCompanion(textpath: drift.Value(newname)));
      await _db.update(_db.textButtons)
        ..where((t) => t.textpath.equals(text.path))
        ..write(TextButtonsCompanion(textpath: drift.Value(newname)));
      Logger().d('textpath更改成功:${newname}');
    } catch (e) {
      Logger().d('textpath更改失败:"${e}"');
    }
  }

  Future<void> deletetextpath(t.Text text) async {
    await (_db.delete(_db.textPaths)
          ..where((t) {
            return t.id.equals(text.id);
          }))
        .go();
    await (_db.delete(_db.textButtons)
          ..where((t) =>
              t.textpath.equals(text.path) & t.seminar.equals(text.seminar)))
        .go();
  }

  Future<List<t.Text>> selecttext(String seminarname) async {
    try {
      final results = await _db.select(_db.textPaths)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final pathlist = await results.get();
      List<t.Text> textpaths = [];
      for (TextPath result in pathlist) {
        textpaths.add(t.Text(
            id: result.id, seminar: result.seminar, path: result.textpath));
      }
      Logger().d('text获取成功:${textpaths}');
      return textpaths;
    } catch (e) {
      Logger().d('text获取失败："${e}"');
      return [];
    }
  }

  Future<void> deletetextbt(tb.TextButtonModel tbm) async {
    await (_db.delete(_db.textButtons)
          ..where((t) {
            return t.id.equals(tbm.id);
          }))
        .go();
  }

  Future<List<tb.TextButtonModel>> selecttb(String seminarname) async {
    try {
      final results = await _db.select(_db.textButtons)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final buttonlist = await results.get();
      List<tb.TextButtonModel> textbuttons = [];
      for (TextButton result in buttonlist) {
        textbuttons.add(tb.TextButtonModel(
            id: result.id,
            seminar: result.seminar,
            path: result.textpath,
            position: Offset(result.dx, result.dy),
            name: result.name));
      }
      Logger().d('text获取成功:${textbuttons}');
      return textbuttons;
    } catch (e) {
      Logger().d('text获取失败："${e}"');
      return [];
    }
  }

  Future<void> insertimage(String imagepath, String seminar) async {
    try {
      await _db.into(_db.imagePaths).insert(
            ImagePathsCompanion(
                imagepath: drift.Value(imagepath),
                seminar: drift.Value(seminar)),
          );
      Logger().d('image更新成功');
    } catch (e) {
      Logger().d('image更新失败："${e}"');
    }
  }

  Future<void> updateimagepath(
      String seminar, String oldname, String newname) async {
    try {
      await _db.update(_db.imagePaths)
        ..where((t) => t.imagepath.equals(oldname))
        ..write(ImagePathsCompanion(imagepath: drift.Value(newname)));
      Logger().d('imagepath更改成功:${newname}');
    } catch (e) {
      Logger().d('imagepath更改失败:"${e}"');
    }
  }

  Future<void> deleteimagepath(String imagepath, String seminar) async {
    await (_db.delete(_db.imagePaths)
          ..where((t) {
            return t.imagepath.equals(imagepath) & t.seminar.equals(seminar);
          }))
        .go();
  }

  Future<List<image.Image>> selectimage(String seminarname) async {
    try {
      final results = await _db.select(_db.imagePaths)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final pathlist = await results.get();
      List<image.Image> imagepaths = [];
      for (ImagePath result in pathlist) {
        imagepaths.add(image.Image(
          id: result.id,
          seminar: result.seminar,
          path: result.imagepath,
        ));
      }
      Logger().d('image获取成功:${imagepaths}');
      return imagepaths;
    } catch (e) {
      Logger().d('image获取失败："${e}"');
      return [];
    }
  }

  Future<void> insertpaintpaths(List<Offset> paintpaths, String seminar) async {
    try {
      await _db.into(_db.paintPaths).insert(
            PaintPathsCompanion(
                paths: drift.Value(tpp.Paths(paintpaths)),
                seminar: drift.Value(seminar),
                description: drift.Value('')),
          );
      Logger().d('paintpaths更新成功:${paintpaths}');
    } catch (e) {
      Logger().d('paintpaths更新失败："${e}"');
    }
  }

  Future<void> deletepaintpath(int id, String seminar) async {
    try {
      await (_db.delete(_db.paintPaths)
            ..where((t) {
              return t.id.equals(id) & t.seminar.equals(seminar);
            }))
          .go();
      Logger().d('删除成功');
    } catch (e) {
      Logger().d('删除失败${e}');
    }
  }

  Future<List<pp.Paintpaths>> selectpaintpaths(String seminarname) async {
    try {
      final results = await _db.select(_db.paintPaths)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final pathslist = await results.get();
      List<pp.Paintpaths> pathlist = [];
      for (PaintPath result in pathslist) {
        pathlist.add(pp.Paintpaths(
            description: result.description,
            paths: result.paths!.paths,
            id: result.id,
            seminar: result.seminar));
      }
      Logger().d('paintpathlist获取成功:${pathlist}');
      return pathlist;
    } catch (e) {
      Logger().d('paintpathlist获取失败:"${e}"');
      return [];
    }
  }

  Future<void> insertreferences(String referencepath, String seminar) async {
    try {
      await _db.into(_db.referencePaths).insert(
            ReferencePathsCompanion(
                referencepath: drift.Value(referencepath),
                seminar: drift.Value(seminar)),
          );
      Logger().d('referencepath插入成功');
    } catch (e) {
      Logger().d('referencepath插入失败："${e}"');
    }
  }

  Future<void> updatereferences(
      String seminar, String oldbasename, String newbasename) async {
    try {
      await _db.update(_db.referencePaths)
        ..where((t) => t.referencepath.equals(oldbasename))
        ..write(
            ReferencePathsCompanion(referencepath: drift.Value(newbasename)));
      await _db.update(_db.referenceButtons)
        ..where((t) => t.referencepath.equals(oldbasename))
        ..write(
            ReferenceButtonsCompanion(referencepath: drift.Value(newbasename)));
      Logger().d('ReferencePath更改成功:${newbasename}');
    } catch (e) {
      Logger().d('ReferencePath更改失败:"${e}"');
    }
  }

  Future<void> deletereferences(String referencepath, String seminar) async {
    await (_db.delete(_db.referencePaths)
          ..where((t) {
            return t.referencepath.equals(referencepath) &
                t.seminar.equals(seminar);
          }))
        .go();
    await (_db.delete(_db.referenceButtons)
          ..where((t) =>
              t.referencepath.equals(referencepath) &
              t.seminar.equals(seminar)))
        .go();
  }

  Future<List<r.Reference>> selectreferences(String seminarname) async {
    try {
      final results = await _db.select(_db.referencePaths)
        ..where((t) => t.seminar.equals(seminarname))
        ..get();
      final pathlist = await results.get();
      List<r.Reference> referencepaths = [];
      for (ReferencePath result in pathlist) {
        referencepaths.add(r.Reference(
          id: result.id,
          seminar: result.seminar,
          path: result.referencepath,
        ));
      }
      Logger().d('ReferencePath获取成功:${ReferencePath}');
      return referencepaths;
    } catch (e) {
      Logger().d('ReferencePath获取失败："${e}"');
      return [];
    }
  }

  //////

  Future<List<rb.ReferenceButtonModel>> selectrb(String seminar) async {
    try {
      final results = await _db.select(_db.referenceButtons)
        ..where((t) => t.seminar.equals(seminar))
        ..get();
      final keyresults = await results.get();
      List<rb.ReferenceButtonModel> lists = [];
      for (ReferenceButton result in keyresults) {
        lists.add(rb.ReferenceButtonModel(
            name: result.name,
            position: Offset(result.dx, result.dy),
            id: result.id,
            seminar: result.seminar,
            description: result.description));
      }
      Logger().d('ReferenceButtons获取成功');
      return lists;
    } catch (e) {
      Logger().d('ReferenceButtons获取失败："${e}"');
      return [];
    }
  }

  Future<void> updaterb(int id, Offset offset) async {
    try {
      await _db.update(_db.referenceButtons)
        ..where((t) => t.id.equals(id))
        ..write(ReferenceButtonsCompanion(
            dx: drift.Value(offset.dx), dy: drift.Value(offset.dy)));
      Logger().d('ReferenceButtons更新成功');
    } catch (e) {
      Logger().d('ReferenceButtons更新失败："${e}"');
    }
  }

  Future<void> insertrb(
      {required String seminar,
      required String name,
      required String referencepath,
      required double dx,
      required double dy,
      required int stamp}) async {
    try {
      await _db.into(_db.referenceButtons).insert(ReferenceButtonsCompanion(
          seminar: drift.Value(seminar),
          referencepath: drift.Value(name),
          description: drift.Value('这个人太懒没有写注释'),
          dx: drift.Value(dx),
          dy: drift.Value(dy),
          name: drift.Value(referencepath)));
      Logger().d('ReferenceButtons插入成功');
    } catch (e) {
      Logger().d('ReferenceButtons插入失败："${e}"');
    }
  }

  Future<void> deleterb(int id) async {
    try {
      await (_db.delete(_db.referenceButtons)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
      Logger().d('referencebutton删除成功');
    } catch (e) {
      Logger().d('referencebutton删除失败${e}');
    }
  }

  Future<void> inserttextbt({
    required String seminar,
    required String path,
    required double dx,
    required double dy,
  }) async {
    try {
      await _db.into(_db.textButtons).insert(TextButtonsCompanion(
            seminar: drift.Value(seminar),
            textpath: drift.Value(path),
            dx: drift.Value(dx),
            dy: drift.Value(dy),
          ));

      Logger().d('textbt插入成功');
    } catch (e) {
      Logger().d('textbt插入失败："${e}"');
    }
  }

  Future<void> updatetextbt(tb.TextButtonModel tbm, Offset newposition) async {
    try {
      await _db.update(_db.textButtons)
        ..where((t) => t.id.equals(tbm.id))
        ..write(TextButtonsCompanion(
            dx: drift.Value(newposition.dx), dy: drift.Value(newposition.dy)));
      Logger().d('textbt更新成功');
    } catch (e) {
      Logger().d('textbt更新失败:"${e}"');
    }
  }

  Future<String> exportJson(sl.SeminarLibrary seminar) async {
    try {
      var audio = await selectaudio(seminar.name);
      var ab = await selectaudiobt(seminar.name);
      var pdf = await selectpdf(seminar.name);
      var t = await selecttext(seminar.name);
      var tb = await selecttb(seminar.name);
      var image = await selectimage(seminar.name);
      var pp = await selectpaintpaths(seminar.name);
      var r = await selectreferences(seminar.name);
      var seminarLibraries = await selectseminar();
      var s = seminarLibraries
          .where((element) => element.name == seminar.name)
          .toList()[0];

      var data = {
        'Seminar': s,
        'AudioPaths': audio,
        'TextPaths': t,
        'ImagePaths': image,
        'PdfPaths': pdf,
        'TimeStamps': ab,
        'TextButtons': tb,
        'PaintPaths': pp,
        'References': r,
      };

      String jsonData = jsonEncode(data);

      // 将JSON数据写入文件

      Logger().d('JSON数据导出完成');
      return jsonData;
    } catch (e) {
      Logger().d('JSON数据导出失败：${e}');
      return '';
    }
  }

  Future<void> importjson(File jsonFile) async {
    try {
      String jsonString = await jsonFile.readAsString();
      Map<String, dynamic> jsonData = json.decode(jsonString);

      sl.SeminarLibrary seminar =
          sl.SeminarLibrary.fromMap(jsonData['Seminar']);

      List<Map<String, dynamic>> audioPaths =
          (jsonData['AudioPaths'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> textPaths =
          (jsonData['TextPaths'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> imagePaths =
          (jsonData['ImagePaths'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> pdfPaths =
          (jsonData['PdfPaths'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> timeStamps =
          (jsonData['TimeStamps'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> textButtons =
          (jsonData['TextButtons'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> paintPaths =
          (jsonData['PaintPaths'] as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> references =
          (jsonData['References'] as List).cast<Map<String, dynamic>>();

      await _db.transaction(() async {
        await insertseminar(
            seminar.name, seminar.initiator, seminar.description);

        for (var e in audioPaths) {
          await insertaudio(e['seminar'], e['path']);
        }

        for (var e in textPaths) {
          await inserttext(e['path'], e['seminar']);
        }

        for (var e in imagePaths) {
          await insertimage(e['path'], e['seminar']);
        }

        for (var e in pdfPaths) {
          await insertpdf(e['seminar'], e['path']);
        }

        for (var e in paintPaths) {
          await insertpaintpaths(e['paths'], e['seminar']);
        }

        for (var e in references) {
          await insertreferences(e['seminar'], e['path']);
        }

        for (var e in timeStamps) {
          await insertaudiobt(
              seminar: e['seminar'],
              name: e['name'],
              dx: e['position'][0],
              dy: e['position'][1],
              stamp: e['stamp']);
        }

        for (var e in textButtons) {
          await inserttextbt(
            seminar: e['seminar'],
            path: e['path'],
            dx: e['position'][0],
            dy: e['position'][1],
          );
        }
      });
      Logger().d('JSON数据已成功导入并存储到数据库中');
    } catch (e) {
      Logger().d('JSON数据导入失败：${e}');
    }
  }

  static Future<String> getabpath(
      String seminar, String type, String name) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirname = dir.path;
    String typepath = p.join(dirname, seminar, type, name);
    return typepath;
  }

  static Future<String> getdestinateddir(String seminar, String type) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirname = dir.path;
    String typepath = p.join(dirname, seminar, type);
    return typepath;
  }

  static Future<String> getseminardir(String seminar) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirname = dir.path;
    String typepath = p.join(dirname, seminar);
    return typepath;
  }
}
