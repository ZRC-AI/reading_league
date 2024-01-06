import 'package:reading_league/controller/database_controller/databasecontroller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reading_league/database/tables/paint_path.dart';
import '../../model/paint_path.dart';

class DrawingController extends GetxController {
  static DrawingController get to => Get.find();
  final DatabaseController dbcontroller = Get.put(DatabaseController());
  final PdfController pdfcontroller = Get.put(PdfController());
  List<Offset> newpath = [];
  List<Paintpaths> paths = [];
  var eraser = false.obs;
  var canDrawing = false.obs;
  void onInit() async {
    paths = await dbcontroller.selectpaintpaths(pdfcontroller.seminar!);
    super.onInit();
  }

  void addPoint(BuildContext context, Offset point, bool canDrawing) {
    if (canDrawing == true && eraser == false) {
      newpath.add(point);
    } else if (canDrawing == false && eraser == true) {
      newpath.add(point);
    }
    update(); // 通知GetX更新UI
  }

  void startDrawing(BuildContext context, Offset startPoint, bool canDrawing) {
    if (canDrawing == true && eraser == false) {
      newpath = [startPoint];
    } else if (canDrawing == false && eraser == true) {
      newpath = [startPoint];
    }
    update(); // 通知GetX更新UI
  }

  void stopDrawing(bool canDrawing) async {
    if (canDrawing == true && eraser == false) {
      dbcontroller.insertpaintpaths(newpath, pdfcontroller.seminar!);
      paths = await dbcontroller.selectpaintpaths(pdfcontroller.seminar!);
    } else if (canDrawing == false && eraser == true) {
      for (Offset point in newpath) {
        for (Paintpaths path in paths) {
          if (path.paths.contains(point)) {
            await dbcontroller.deletepaintpath(path.id, pdfcontroller.seminar!);
          }
        }
      }
      newpath = [];
      paths = await dbcontroller.selectpaintpaths(pdfcontroller.seminar!);
    }
    update(); // 通知GetX更新UI
  }
}
