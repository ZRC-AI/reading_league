import 'dart:ui';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path/path.dart' as p;

class TextPreview extends StatelessWidget {
  final BuildContext context;

  final TextController textcontroller = Get.put(TextController());
  final PdfController pdfcontroller = Get.put(PdfController());
  TextPreview(this.context);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            SingleChildScrollView(
                child: Screenshot(
                    key: textcontroller.screenshotKey.value,
                    controller: textcontroller.screenshotController,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Markdown(
                              imageDirectory:
                                  p.join(pdfcontroller.globaldir!, 'images'),
                              data: textcontroller.textcontent.value,
                              selectable: true,
                              softLineBreak: true)),
                    ))),
            SizedBox(
              height: 15,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Center(
                    child: TextButton(
                  onPressed: () {
                    textcontroller.rename(textcontroller.textname.value,
                        pdfcontroller.seminar!, context);
                  },
                  child: Text(
                    '${textcontroller.textname.value}-预览模式',
                    style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                )),
              ),
            ),
          ],
        ));
  }
}
