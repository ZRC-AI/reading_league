import 'dart:io';

import 'package:reading_league/controller/database_controller/databasecontroller.dart';
import 'package:reading_league/controller/pdfview_controller/audio_button_controller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:reading_league/model/audio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class AudioPathsController extends GetxController {
  final DatabaseController dbcontroller = Get.put(DatabaseController());
  final PdfController pdfcontroller = Get.put(PdfController());
  final AudioButtonController abcontroller = Get.put(AudioButtonController());
  var audiopaths = <Audio>[].obs;
  String? isplayingaudio;
  String userInput = '';

  @override
  Future<void> onInit() async {
    selectaudio();

    super.onInit();
  }

  Future<void> selectaudio() async {
    audiopaths.value = await dbcontroller.selectaudio(pdfcontroller.seminar!);
  }

  Future<void> deleteaudio(Audio audio, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('确认删除？'),
          actions: [
            ElevatedButton(
              child: Text('cancel'),
              onPressed: () {
                userInput = '';
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('commit'),
              onPressed: () async {
                Directory dir = await getApplicationDocumentsDirectory();
                String dirname = dir.path;
                String filepath =
                    p.join(dirname, audio.seminar, 'audios', audio.path);
                try {
                  final file = File(filepath);
                  if (await file.exists()) {
                    await file.delete();
                    await dbcontroller.deleteaudio(audio);
                    audiopaths.value =
                        await dbcontroller.selectaudio(audio.seminar);
                    abcontroller.buttons.value =
                        await dbcontroller.selectaudiobt(audio.seminar);
                  } else {
                    await dbcontroller.deleteaudio(audio);
                    audiopaths.value =
                        await dbcontroller.selectaudio(audio.seminar);
                    abcontroller.buttons.value =
                        await dbcontroller.selectaudiobt(audio.seminar);
                  }

                  Logger().d("删除成功");
                } catch (e) {
                  Logger().d("删除失败：${e}");
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> rename(Audio audio, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('重命名'),
          content: TextField(
            onChanged: (value) {
              userInput = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: Text('cancel'),
              onPressed: () {
                userInput = '';
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('commit'),
              onPressed: () async {
                Directory dir = await getApplicationDocumentsDirectory();
                String dirname = dir.path;
                String oldpath =
                    p.join(dirname, audio.seminar, 'audios', audio.path);
                final File oldFile = File(oldpath);
                print(dir);
                print(audio.seminar + 'dingwei');

                try {
                  await oldFile.exists();
                  String newname = userInput + '.wav';
                  String newpath =
                      p.join(dirname, audio.seminar, 'audios', newname);
                  final File newFile = await oldFile.rename(newpath);

                  await dbcontroller.updateaudiopath(
                      audio.seminar, audio.path, p.basename(newFile.path));
                  abcontroller.buttons.value =
                      await dbcontroller.selectaudiobt(audio.seminar);
                  Logger().d('正常${newFile.path}');
                  audiopaths.value =
                      await dbcontroller.selectaudio(audio.seminar);
                } catch (e) {
                  Logger().d('出错${e}');
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
