import 'dart:io';
import 'dart:typed_data';

import 'package:reading_league/controller/database_controller/databasecontroller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/model/image.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reading_league/model/text.dart';
import '../project_controller/file_picker_controller.dart';
import 'package:path/path.dart' as p;
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as i;

class TextController extends GetxController {
  final DatabaseController dbcontroller = Get.put(DatabaseController());
  final PdfController pdfcontroller = Get.put(PdfController());
  var textpaths = <Text>[].obs;
  var imagepaths = <Image>[].obs;
  var textcontent = ''.obs;
  var textname = ''.obs;
  String userInput = '';
  final ScreenshotController screenshotController = ScreenshotController();
  var screenshotKey = flutter.GlobalKey<ScreenshotState>().obs;

  @override
  Future<void> onInit() async {
    textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
    ever(screenshotKey, (callback) {
      if (flutter.WidgetsBinding.instance.lifecycleState ==
          flutter.AppLifecycleState.resumed) {
        // 在 widget 构建完成后，执行截图操作
        savetext();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    Get.delete();
    super.onClose();
  }

  Future<void> gettext(Text text) async {
    try {
      var abtextpath =
          await DatabaseController.getabpath(text.seminar, 'texts', text.path);
      var textfile = File(abtextpath);
      var content = await textfile.readAsString();
      textname.value = text.path;
      textcontent.value = content;
      Logger().d('解析text成功');
    } catch (e) {
      Logger().d('解析text出错${e}');
    }
  }

  Future<Uint8List> showimage(Text? text, Image? image) async {
    if (text != null && image == null) {
      String imagepath = changeExtension(text.path, 'png');
      String dirname =
          await DatabaseController.getdestinateddir(text.seminar, 'texts');
      Uint8List bytes = await File(p.join(dirname, imagepath)).readAsBytes();
      return bytes;
    } else if (text == null && image != null) {
      String dirname =
          await DatabaseController.getdestinateddir(image.seminar, 'images');
      Uint8List bytes = await File(p.join(dirname, image.path)).readAsBytes();
      return bytes;
    } else {
      return Uint8List(1);
    }
  }

  Future<void> updatetext(String textpath, String newcontent) async {
    try {
      var textfile = File(textpath);
      await textfile.writeAsString(newcontent);
      textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
      Logger().d('text文本修改成功');
    } catch (e) {
      Logger().d('text文本修改出错${e}');
    }
  }

  Future<void> deletetextpath(Text text) async {
    try {
      await dbcontroller.deletetextpath(text);
      var filename =
          await DatabaseController.getabpath(text.seminar, 'texts', text.path);
      var file = File(filename);
      await file.delete();
      textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
      Logger().d('删除文本成功');
    } catch (e) {
      Logger().d('删除文本失败：${e}');
    }
  }

  Future<void> updatetextpath(Text text, String newname) async {
    try {
      var textpath =
          await DatabaseController.getabpath(text.seminar, 'texts', text.path);
      var textfile = File(textpath);
      var newpath =
          await DatabaseController.getabpath(text.seminar, 'texts', newname);
      await textfile.rename(newpath);
      await dbcontroller.updatetextpath(text, newname);
      textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
      Logger().d('text文件名修改成功');
    } catch (e) {
      Logger().d('text文件名修改出错${e}');
    }
  }

  Future<void> inserttextpath() async {
    var paths = await FilePickerController.pickTextFiles(false);

    for (var textpath in paths) {
      File sourceFile = File(textpath);
      String abpath = await DatabaseController.getabpath(
          pdfcontroller.seminar!, 'texts', p.basename(textpath));
      await sourceFile.copy(abpath);
      await dbcontroller.inserttext(
          p.basename(textpath), pdfcontroller.seminar!);
    }
    textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
    pdfcontroller.textdrawertoggle.value = true;
    pdfcontroller.textdrawerstate.value = TextDrawerState.preview;
  }

  Future<void> insertimagepath() async {
    var paths = await FilePickerController.pickImageFiles(true);
    for (var imagepath in paths) {
      File sourceFile = File(imagepath);
      String abpath = await DatabaseController.getabpath(
          pdfcontroller.seminar!, 'images', p.basename(imagepath));
      await sourceFile.copy(abpath);
      print(abpath);
      await dbcontroller.insertimage(
          p.basename(imagepath), pdfcontroller.seminar!);
    }
    imagepaths.value = await dbcontroller.selectimage(pdfcontroller.seminar!);
  }

  Future<void> selectimagepath() async {
    imagepaths.value = await dbcontroller.selectimage(pdfcontroller.seminar!);
  }

  Future<void> selecttextpath() async {
    textpaths.value = await dbcontroller.selecttext(pdfcontroller.seminar!);
  }

  Future<void> createtext(flutter.BuildContext context) async {
    flutter.showDialog(
      context: context,
      builder: (context) {
        return flutter.AlertDialog(
          title: flutter.Text('新建笔记'),
          content: flutter.TextField(
            onChanged: (value) {
              userInput = value;
            },
          ),
          actions: [
            flutter.ElevatedButton(
              child: flutter.Text('cancel'),
              onPressed: () {
                flutter.Navigator.pop(context);
              },
            ),
            flutter.ElevatedButton(
              child: flutter.Text('commit'),
              onPressed: () async {
                Directory dir = await getApplicationDocumentsDirectory();
                String dirname = dir.path;
                String newname = userInput + '.md';

                String path =
                    p.join(dirname, pdfcontroller.seminar!, 'texts', newname);

                int dotIndex = path.lastIndexOf('.');
                String basepath = path.substring(0, dotIndex);
                String imagepath = basepath + '.png';
                Logger().d(imagepath);
                try {
                  final File newFile = File(path);
                  final image = i.Image(width: 40, height: 70);
                  Directory theDir = Directory(
                      p.join(dir.path, pdfcontroller.seminar!, 'texts'));

                  final files = theDir.listSync();
                  if (files.any((file) =>
                      file is File && file.uri.pathSegments.last == path)) {
                    Get.snackbar('error', '已存在同名文件');
                  } else {
                    newFile.create();
                    File(imagepath)
                        .writeAsBytes(Uint8List.fromList(i.encodePng(image)));
                    await dbcontroller.inserttext(
                        newname, pdfcontroller.seminar!);
                    selecttextpath();
                    userInput = '';
                    Logger().d('新建成功${newFile.path}');
                  }
                } catch (e) {
                  Logger().d('出错${e}');
                }
                flutter.Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> savetext() async {
    var filename = await DatabaseController.getabpath(
        pdfcontroller.seminar!, 'texts', textname.value);
    var file = File(filename);
    try {
      await file.writeAsString(textcontent.value);
      print('File written successfully.');
    } catch (e) {
      print('Error writing to file: $e');
    }

    screenshotController.capture(pixelRatio: 5).then((value) async {
      int dotIndex = filename.lastIndexOf('.');
      String basepath = filename.substring(0, dotIndex);
      String textimagepath = basepath + '.png';
      final File imageFile = File(textimagepath);
      await imageFile.writeAsBytes(value!, mode: FileMode.write);
      Logger().d('text:${filename}, image${textimagepath}');
    });
  }

  Future<void> rename(
      String oldname, String seminar, flutter.BuildContext context) async {
    // ignore: use_build_context_synchronously
    flutter.showDialog(
      context: context,
      builder: (context) {
        return flutter.AlertDialog(
          title: flutter.Text('重命名'),
          content: flutter.TextField(
            onChanged: (value) {
              userInput = value;
            },
          ),
          actions: [
            flutter.ElevatedButton(
              child: flutter.Text('cancel'),
              onPressed: () {
                flutter.Navigator.pop(context);
              },
            ),
            flutter.ElevatedButton(
              child: flutter.Text('commit'),
              onPressed: () async {
                Directory dir = await getApplicationDocumentsDirectory();
                String dirname = dir.path;
                String oldpath = p.join(dirname, seminar, 'texts', oldname);

                int dotIndex = oldpath.lastIndexOf('.');
                String basepath = oldpath.substring(0, dotIndex);
                String oldimagepath = basepath + '.png';

                final File oldFile = File(oldpath);
                final File oldImage = File(oldimagepath);
                String newname = userInput + '.md';
                String newpath = p.join(dirname, seminar, 'texts', newname);
                int newdotIndex = newpath.lastIndexOf('.');
                String newbasepath = newpath.substring(0, newdotIndex);
                String newimagepath = newbasepath + '.png';

                try {
                  Text text = textpaths
                      .where((element) => element.path == oldname)
                      .first;
                  final File newFile = await oldFile.rename(newpath);
                  await oldImage.rename(newimagepath);

                  await dbcontroller.updatetextpath(
                      text, p.basename(newFile.path));
                  textname.value = newname;
                  Logger().d('重命名成功${newFile.path}');
                  textpaths.value = await dbcontroller.selecttext(seminar);
                  userInput = '';
                } catch (e) {
                  userInput = '';
                  Logger().d('出错${e}');
                }
                flutter.Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String changeExtension(String path, String extension) {
    int dotIndex = path.lastIndexOf('.');

    // 使用substring将扩展名之前的部分提取出来
    String pathWithoutExtension = path.substring(0, dotIndex);

    // 创建新路径，附加新的扩展名
    String newPath = pathWithoutExtension + '.' + extension;

    return newPath;
  }
}
