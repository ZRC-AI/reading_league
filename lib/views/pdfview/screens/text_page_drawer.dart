import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';

import 'package:reading_league/views/pdfview/widgets/text_edit.dart';
import 'package:reading_league/views/pdfview/widgets/text_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TextPageDrawer extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pdfcontroller.textdrawerstate == TextDrawerState.edit) {
        return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: TextEdit(context),
                )));
      } else {
        return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: TextPreview(context),
                )));
      }
    });
  }
}
