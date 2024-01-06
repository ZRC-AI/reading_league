import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:reading_league/views/pdfview/widgets/image_preview.dart';

import 'package:reading_league/views/pdfview/widgets/text_previews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PreviewDrawerPage extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());
  final TextController textcontroller = Get.put(TextController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pdfcontroller.previewdrawerstate.value ==
          PreviewDrawerState.textpreviews) {
        return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: TextPreviews(),
                )));
      } else {
        return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  child: ImagePreviews(),
                )));
      }
    });
  }
}
