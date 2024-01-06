import 'dart:io';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';

import 'package:reading_league/model/seminar.dart';
import 'package:file_picker/file_picker.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../database_controller/databasecontroller.dart';

class SeminarController extends GetxController {
  final DatabaseController dbController = Get.put(DatabaseController());
  var seminars = <SeminarLibrary>[].obs;
  void onInit() async {
    await selectSeminar();
    super.onInit();
  }

  Future<void> pickAndCreateProjectFolder(String name, String initiator,
      String description, List<File> selectedPdfFiles) async {
    if (selectedPdfFiles.isEmpty) {
      Get.snackbar('Error', 'Please select a PDF file.');
      return;
    }

    if (name.isEmpty || initiator.isEmpty) {
      Get.snackbar('Error', 'Project name and initiator are required.');
      return;
    }

    try {
      // 获取应用文档目录
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // 创建项目文件夹
      String seminarFolderPath = path.join(documentsDirectory.path, name);
      String audiosFolderPath =
          path.join(documentsDirectory.path, name, 'audios');
      String textsFolderPath =
          path.join(documentsDirectory.path, name, 'texts');
      String imagesFolderPath =
          path.join(documentsDirectory.path, name, 'images');

      String pdfsFolderPath = path.join(documentsDirectory.path, name, 'pdfs');
      String referencesFolderPath =
          path.join(documentsDirectory.path, name, 'references');

      if (await Directory(seminarFolderPath).exists()) {
        Get.snackbar('Error', 'seminar folder already exists.');
        return;
      }

      await Directory(seminarFolderPath).create();
      await Directory(audiosFolderPath).create();
      await Directory(textsFolderPath).create();
      await Directory(imagesFolderPath).create();
      await Directory(pdfsFolderPath).create();

      await Directory(referencesFolderPath).create();

      // 创建PDF文件库并添加选中的PDF文件
      for (File selectedPdfFile in selectedPdfFiles) {
        String fileName = path.basename(selectedPdfFile.path);
        String destinationFilePath = path.join(pdfsFolderPath, fileName);
        await File(selectedPdfFile.path).copy(destinationFilePath);
        var dotindex = fileName.lastIndexOf('.');
        String pdfimagesFolderPath =
            path.join(pdfsFolderPath, fileName.substring(0, dotindex));
        await Directory(pdfimagesFolderPath).create(recursive: true);
        await dbController.insertpdf(name, fileName);
      }

      SeminarLibrary seminar = SeminarLibrary(
          name: name, initiator: initiator, description: description);

      await dbController.insertseminar(name, initiator, description);
      await selectSeminar();

      final PdfController pdfController = Get.put(PdfController());

      // 导航到新界面
      pdfController.topdfview(seminar.name);
      Get.snackbar('Completed', 'Create Project Success!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create project folder: $e');
    }
  }

  Future<void> exportSeminar(SeminarLibrary seminar) async {
    Directory? destinationDir = await getApplicationDocumentsDirectory();
    Directory? sourceDir = await getApplicationDocumentsDirectory();

    if (sourceDir == null && destinationDir == null) {
      Get.snackbar('error', 'sourceDir does not exsit');
      return;
    }

    var jsondata = await dbController.exportJson(seminar);
    final destinationFolder =
        Directory(path.join(destinationDir.path, 'export', seminar.name));
    final sourceFolder = Directory(path.join(sourceDir.path, seminar.name));
    final jsonfile = File(path.join(sourceFolder.path, 'data.json'));
    await jsonfile.create();
    await jsonfile.writeAsString(jsondata);

    var valid = await _isValidFolderStructure(sourceFolder);
    try {
      // 检查目录结构的代码
      if (!valid) {
        throw InvalidDirectoryStructureException('目录结构不合法');
      }
      await _copyDirectory(sourceFolder, destinationFolder);
      _openFolder(destinationFolder.path);
    } catch (e) {
      if (e is InvalidDirectoryStructureException) {
        Logger().d('发生了目录结构不合法的错误：${e.message}');
        // 处理错误的逻辑
      } else {
        Logger().d('发生了未知错误：${e}');
      }
    }
  }

  Future<void> importSeminar() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath();
    if (folderPath == null) {
      return;
    }
    Directory sourceDir = Directory(folderPath);
    Directory dir = await getApplicationDocumentsDirectory();

    Directory destinationDir =
        Directory(path.join(dir.path, path.basename(sourceDir.path)));
    var valid = await _isValidFolderStructure(sourceDir);

    try {
      // 检查目录结构的代码
      if (!valid) {
        throw InvalidDirectoryStructureException('目录结构不合法');
      }
      await _copyDirectory(sourceDir, destinationDir);
      await dbController
          .importjson(File(path.join(destinationDir.path, 'data.json')));
      await selectSeminar();
    } catch (e) {
      if (e is InvalidDirectoryStructureException) {
        Logger().d('发生了目录结构不合法的错误：${e.message}');
        // 处理错误的逻辑
      } else {
        // 处理其他类型的异常
      }
    }
  }

  Future<void> pullSeminar() async {}
  Future<void> pushSeminar() async {}

  Future<void> deleteSeminar(SeminarLibrary seminar) async {
    try {
      await dbController.deleteSeminar(seminar);
      await selectSeminar();
      var dirname = await DatabaseController.getseminardir(seminar.name);
      await _deleteDirectory(Directory(dirname));
      Logger().d('成功');
    } catch (e) {
      Logger().d('$e');
    }
  }

  Future<void> selectSeminar() async {
    seminars.value = await dbController.selectseminar();
  }

  Future<void> _copyDirectory(Directory source, Directory destination) async {
    try {
      if (!destination.existsSync()) {
        await destination.create(recursive: true);
      }

      await source.list().forEach((FileSystemEntity entity) async {
        if (entity is File) {
          File file = File(entity.path);
          String newPath =
              path.join(destination.path, path.basename(file.path));
          await file.copy(newPath);
        } else if (entity is Directory) {
          Directory dir = Directory(entity.path);
          String newPath = path.join(destination.path, path.basename(dir.path));
          await dir.create(recursive: true);
          await _copyDirectory(dir, Directory(newPath));
        }
      });
    } catch (e) {
      await _deleteDirectory(destination);
      Logger().d(e);
      rethrow;
    }
  }

  void _openFolder(String path) {
    if (Platform.isWindows) {
      _openFolderOnWindows(path); // 替换为你的Windows文件夹路径
    } else if (Platform.isMacOS) {
      _openFolderOnMac(path); // 替换为你的macOS文件夹路径
    } else {
      print('不支持的操作系统');
    }
  }

  void _openFolderOnWindows(String folderPath) {
    // 在Windows上打开资源管理器并导航到文件夹
    Process.run('explorer.exe', ['/select,', folderPath]);
  }

  void _openFolderOnMac(String folderPath) {
    // 在macOS上打开Finder并导航到文件夹
    Process.run('open', [folderPath]);
  }

  Future<void> _deleteDirectory(Directory directory) async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      print('文件夹已成功删除');
    } else {
      print('文件夹不存在');
    }
  }

  bool _isValidFolderStructure(Directory rootDirectory) {
    // 验证根目录是否存在
    if (!rootDirectory.existsSync()) {
      return false;
    }

    // 验证根目录下是否存在必须的文件夹
    Directory pdfsDirectory = Directory(path.join(rootDirectory.path, 'pdfs'));
    Directory referencesDirectory =
        Directory(path.join(rootDirectory.path, 'references'));
    Directory imagesDirectory =
        Directory(path.join(rootDirectory.path, 'images'));
    Directory textsDirectory =
        Directory(path.join(rootDirectory.path, 'texts'));
    Directory audiosDirectory =
        Directory(path.join(rootDirectory.path, 'audios'));

    if (!pdfsDirectory.existsSync() ||
        !referencesDirectory.existsSync() ||
        !imagesDirectory.existsSync() ||
        !textsDirectory.existsSync() ||
        !audiosDirectory.existsSync()) {
      return false;
    }

    // 验证pdfs目录下是否存在一个PDF文件和一个同名的文件夹
    List<FileSystemEntity> pdfsContents = pdfsDirectory.listSync();
    String pdfFileName = '';
    String imagesFolderName = '';

    for (var entity in pdfsContents) {
      if (entity is File && entity.path.endsWith('.pdf')) {
        pdfFileName = entity.uri.pathSegments.last;
      } else if (entity is Directory) {
        imagesFolderName = path.basename(entity.path);
      }
    }

    if (pdfFileName.isEmpty ||
        imagesFolderName.isEmpty ||
        pdfFileName.split('.')[0] != imagesFolderName) {
      return false;
    }

    // 验证images目录下是否仅包含图片文件
    List<FileSystemEntity> imagesContents = imagesDirectory.listSync();
    for (var entity in imagesContents) {
      if (entity is! File ||
          !entity.path.endsWith('.png') && !entity.path.endsWith('.jpg')) {
        return false;
      }
    }

    // 验证texts目录下是否仅包含 .md 和 .png 文件
    List<FileSystemEntity> textsContents = textsDirectory.listSync();
    for (var entity in textsContents) {
      if (entity is! File ||
          !entity.path.endsWith('.md') && !entity.path.endsWith('.png')) {
        return false;
      }
    }

    // 验证audios目录下是否仅包含 .wav 文件
    List<FileSystemEntity> audiosContents = audiosDirectory.listSync();
    for (var entity in audiosContents) {
      if (entity is! File || !entity.path.endsWith('.wav')) {
        return false;
      }
    }

    // 验证是否存在 data.json 文件
    File jsonDataFile = File(path.join(rootDirectory.path, 'data.json'));
    if (!jsonDataFile.existsSync()) {
      return false;
    }

    return true;
  }
}

class InvalidDirectoryStructureException implements Exception {
  final String message;

  InvalidDirectoryStructureException(this.message);

  @override
  String toString() {
    return 'InvalidDirectoryStructureException: $message';
  }
}
