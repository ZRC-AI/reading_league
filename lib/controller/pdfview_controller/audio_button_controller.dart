import 'dart:io';

import 'package:reading_league/controller/database_controller/databasecontroller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/model/audio_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AudioButtonController extends GetxController {
  RxList<AudioButton> buttons = <AudioButton>[].obs;
  final PdfController pdfcontroller = Get.put(PdfController());
  DatabaseController dbcontroller = Get.put(DatabaseController());
  AudioPlayer? audioplayer;
  Duration? position;
  BuildContext? stampcontext;
  var audioplaypausing = true.obs;

  @override
  Future<void> onInit() async {
    buttons.value = await dbcontroller.selectaudiobt(pdfcontroller.seminar!);
    super.onInit();
  }

  Future<void> addrecordButton(
      {required int stamp,
      required String name,
      required String seminar}) async {
    final RenderBox renderBox = stampcontext!.findRenderObject() as RenderBox;
    final position = renderBox
        .globalToLocal(Offset(Offset.zero.dx + 200.0, Offset.zero.dy + 100.0));
    await dbcontroller.insertaudiobt(
        seminar: seminar,
        name: name,
        dx: position.dx,
        dy: position.dy,
        stamp: stamp);
    buttons.value = await dbcontroller.selectaudiobt(seminar);
  }

  Future<void> addplayingButton(
      {required int stamp,
      required String name,
      required String seminar}) async {
    final RenderBox renderBox = stampcontext!.findRenderObject() as RenderBox;
    final position = renderBox
        .globalToLocal(Offset(Offset.zero.dx + 200.0, Offset.zero.dy + 200.0));

    await dbcontroller.insertaudiobt(
        seminar: seminar,
        name: name,
        dx: position.dx,
        dy: position.dy,
        stamp: stamp);
    buttons.value = await dbcontroller.selectaudiobt(seminar);
  }

  Future<void> updateButtonPosition(
      int id, Offset newoffset, String seminar) async {
    await dbcontroller.updateaudiobt(id, newoffset);
    buttons.value = await dbcontroller.selectaudiobt(seminar);
  }

  Future<void> deleteButton(int id, String seminar) async {
    try {
      await dbcontroller.deleteaudiobt(id);
      buttons.value = await dbcontroller.selectaudiobt(seminar);
      Logger().d('音频时间戳删除成功');
    } catch (e) {
      Logger().d('音频时间戳删除失败${e}');
    }
  }

  Future<void> updateButtonTime(
      int shift, int id, String seminar, int stamp) async {
    await dbcontroller.updatebttime(id, shift, stamp);
    buttons.value = await dbcontroller.selectaudiobt(seminar);
  }

  Future<void> seektoplay(String name, String seminar, Duration stamp) async {
    await audioplayer!.stop();
    Directory dir = await getApplicationDocumentsDirectory();
    String dirname = dir.path;
    String path = p.join(dirname, seminar, 'audios', name);
    if (audioplayer == null) {
      Logger().d('audioplayer获取失败');
    } else {
      await audioplayer!.setSource(DeviceFileSource(path));
      await audioplayer!.seek(stamp);
      pdfcontroller.canplaying.value = true;
      audioplaypausing.value = true;
    }
  }
}
