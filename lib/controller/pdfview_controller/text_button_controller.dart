import 'dart:js_util';
import 'dart:ui';

import 'package:reading_league/controller/database_controller/databasecontroller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/model/text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextButtonController extends GetxController {
  final DatabaseController dbcontroller = Get.put(DatabaseController());
  final PdfController pdfcontroller = Get.put(PdfController());
  var textbuttons = <TextButtonModel>[].obs;
  BuildContext? tbcontext;

  @override
  Future<void> onInit() async {
    textbuttons.value = await dbcontroller.selecttb(pdfcontroller.seminar!);
    super.onInit();
  }

  Future<void> selecttextbuttons() async {
    textbuttons.value = await dbcontroller.selecttb(pdfcontroller.seminar!);
  }

  Future<void> updatetb(TextButtonModel tbm, Offset newbutton) async {
    dbcontroller.updatetextbt(tbm, newbutton);
    textbuttons.value = await dbcontroller.selecttb(pdfcontroller.seminar!);
  }

  Future<void> addtb(Offset position, String path) async {
    await dbcontroller.inserttextbt(
        seminar: pdfcontroller.seminar!,
        path: path,
        dx: position.dx,
        dy: position.dy);
    textbuttons.value = await dbcontroller.selecttb(pdfcontroller.seminar!);
  }

  Future<void> deletebt(TextButtonModel tbm) async {
    await dbcontroller.deletetextbt(tbm);
    textbuttons.value = await dbcontroller.selecttb(pdfcontroller.seminar!);
  }

  Future<void> addTextButton(String path) async {
    final RenderBox renderBox = tbcontext!.findRenderObject() as RenderBox;
    final position = renderBox
        .globalToLocal(Offset(Offset.zero.dx + 200.0, Offset.zero.dy + 200.0));
    await addtb(position, path);
  }
}
