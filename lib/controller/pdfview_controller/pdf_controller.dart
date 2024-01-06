// import 'dart:async';

// import 'dart:io';

// import 'dart:typed_data';

// import 'package:reading_league/controller/database_controller/databasecontroller.dart';

// import 'package:reading_league/views/pdfview/screens/pdfviews.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:pdfx/pdfx.dart' as px;

// import 'package:get/get.dart';

// class PdfController extends GetxController {
//   var canplaying = false.obs;
//   var showaudiopath = false.obs;
//   Rx<PreviewDrawerState> previewdrawerstate =
//       Rx<PreviewDrawerState>(PreviewDrawerState.textpreviews);
//   Rx<TextDrawerState> textdrawerstate =
//       Rx<TextDrawerState>(TextDrawerState.preview);
//   final DatabaseController dbController = Get.put(DatabaseController());

//   var previewdrawertoggle = false.obs;
//   var textdrawertoggle = false.obs;
//   var totalheight = 0.0;
//   var scrolloffset = 0.0.obs;
//   var canshow = <bool>[].obs;
//   double soffset = 0.0;
//   String? seminar;
//   final ScrollController scrollController = ScrollController();

//   @override
//   void onInit() {
//     super.onInit();
//     // 在onInit方法中初始化ScrollController
//     scrollController.addListener(() {
//       soffset = scrollController.offset;
//       Future.delayed(Duration(milliseconds: 500), () {
//         if ((scrolloffset.value - soffset).abs() > (800) * 1) {
//           scrolloffset.value = scrollController.offset;
//           int x = (scrolloffset.value / (totalheight + 200)).toInt();
//           canshow[x] = true;
//           canshow[x + 1] = true;
//           canshow[x - 1] = true;
//           canshow[x + 2] = true;
//           canshow[x - 2] = true;
//           print(scrolloffset.value);
//         }
//       });
//       Future.delayed(Duration(milliseconds: 1500), () {
//         scrolloffset.value = scrollController.offset;
//         print(scrolloffset.value);
//       });
//     });
//   }

//   @override
//   void onClose() {
//     scrollController.dispose();
//     super.onClose();
//   }

//   // 由于技术难点，暂时放弃可以选中的pdf文件阅读器，而选择强制将pdf文件转化为图片
//   Future<(double, Uint8List)> _getpdfdata(String seminar) async {
//     var pdfpaths = await dbController.selectpdf(seminar);
//     if (pdfpaths.isEmpty) {
//       print('empty');
//       Get.back();
//     }
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String pdfpath = '${appDocDir.path}/${seminar}/pdfs/${pdfpaths[0]}';
//     double height = 0.0;
//     File file = File(pdfpath);

//     final Uint8List bytes = await file.readAsBytes();
//     final PdfDocument document = PdfDocument(inputBytes: bytes);
//     height = document.pages.count * document.pages[0].size.height;
//     document.dispose();
//     return (height, bytes);
//   }

//   // Future<(double, px.PdfController)> _getpdfcontroller(String seminar) async {
//   //   var pdfpaths = await dbController.selectpdf(seminar);
//   //   if (pdfpaths.isEmpty) {
//   //     print('empty');
//   //     Get.back();
//   //   }
//   //   Directory appDocDir = await getApplicationDocumentsDirectory();
//   //   String pdfpath = '${appDocDir.path}/${seminar}/pdfs/${pdfpaths[0]}';
//   //   double height = 0.0;
//   //   File file = File(pdfpath);

//   //   final Uint8List bytes = await file.readAsBytes();
//   //   final PdfDocument document = PdfDocument(inputBytes: bytes);
//   //   height = document.pages.count * document.pages[0].size.height;

//   //   final pdfPinchController = px.PdfController(
//   //     document: px.PdfDocument.,
//   //   );
//   //   return (height, pdfPinchController);
//   // }

//   Future<void> topdfview(String seminar) async {
//     var data = await _getpdfdata(seminar);
//     this.seminar = seminar;
//     var height = data.$1;
//     var bytes = data.$2;
//     Get.to(pdfviewer(
//       seminar: seminar,
//       height: height,
//       bytes: bytes,
//     ));
//   }
//   // Future<void> topdfview(String seminar) async {
//   //   var data = await _getpdfcontroller(seminar);
//   //   var height = data.$1;
//   //   var pdfPinchController = data.$2;
//   //   Get.to(pdfviewer(
//   //     seminar: seminar,
//   //     pdfPinchController: pdfPinchController,
//   //     height: height,
//   //   ));
//   // }
// }

// enum PreviewDrawerState {
//   pdfpreviews,
//   textpreviews,
// }

// enum TextDrawerState {
//   preview,
//   edit,
// }

import 'dart:async';

import 'dart:io';

import 'dart:typed_data';

import 'package:reading_league/controller/database_controller/databasecontroller.dart';

import 'package:reading_league/views/pdfview/screens/pdfviews.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as i;

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as p;

class PdfController extends GetxController {
  var canplaying = false.obs;
  var showaudiopath = false.obs;
  Rx<PreviewDrawerState> previewdrawerstate =
      Rx<PreviewDrawerState>(PreviewDrawerState.textpreviews);
  Rx<TextDrawerState> textdrawerstate =
      Rx<TextDrawerState>(TextDrawerState.preview);
  final DatabaseController dbController = Get.put(DatabaseController());
  PdfViewerController pdfViewerController = PdfViewerController();

  var previewdrawertoggle = false.obs;
  var textdrawertoggle = false.obs;
  final ScrollController scrollController = ScrollController();
  String? seminar;
  String? globaldir;

  //这段代码无需使用

  Future<(double, Uint8List)> _getpdfdata(String seminar) async {
    var pdfpaths = await dbController.selectpdf(seminar);

    String pdfpath = p.join(globaldir!, 'pdfs', pdfpaths[0].path);
    double height = 0.0;
    File file = File(pdfpath);
    final Uint8List bytes = await file.readAsBytes();
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    height = document.pages.count * document.pages[1].size.height;
    document.dispose();
    return (height, bytes);
  }

  Future<(double, List<Uint8List>)> _getimage(String seminar) async {
    var pdfpaths = await dbController.selectpdf(seminar);

    String pdfimagepath =
        p.join(globaldir!, 'pdfs', pdfpaths[0].path.split('.')[0]);

    Directory folder = Directory(pdfimagepath);
    List<FileSystemEntity> fileList = folder.listSync();

    fileList.sort((a, b) {
      String nameA = a.uri.pathSegments.last; // 获取文件名
      String nameB = b.uri.pathSegments.last; // 获取文件名
      // 提取文件名中的数字部分，然后按数字顺序排序
      int numberA = int.parse(RegExp(r'(\d+)').firstMatch(nameA)!.group(1)!);
      int numberB = int.parse(RegExp(r'(\d+)').firstMatch(nameB)!.group(1)!);
      return numberA - numberB;
    });

    List<Uint8List> imagelist = [];

    for (var entity in fileList) {
      if (entity is File) {
        imagelist.add(entity.readAsBytesSync());
      } else {
        print('Directory: ${entity.path}');
      }
    }

    i.Image? image = await i.decodeImage(imagelist[0]);

    double scale = image!.height / image.width;
    // double totalimageheight = (image!.height * imagelist.length).toDouble();

    // double imagewidth = image.width.toDouble();

    return (scale, imagelist);
  }

  Future<void> topdfview(String seminar) async {
    this.seminar = seminar;
    this.globaldir = await DatabaseController.getseminardir(seminar);
    var data = await _getimage(seminar);
    Get.to(pdfviewer(seminar: seminar, scale: data.$1, images: data.$2));
  }
}

enum PreviewDrawerState {
  imagepreviews,
  textpreviews,
}

enum TextDrawerState {
  preview,
  edit,
}
