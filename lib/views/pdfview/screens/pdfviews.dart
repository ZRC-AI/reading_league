import 'dart:typed_data';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/project_controller/seminar_controller.dart';

import 'package:reading_league/views/pdfview/screens/preview_drawer_page.dart';
import 'package:reading_league/views/pdfview/screens/pdf_page.dart';
import 'package:reading_league/views/pdfview/screens/text_page_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class pdfviewer extends StatelessWidget {
  String seminar;
  double scale;
  List<Uint8List> images;

  pdfviewer({required this.seminar, required this.scale, required this.images});
  @override
  Widget build(BuildContext context) {
    // 更新矩阵中的缩放部分
    return Scaffold(
      body: Center(
          child: Container(
              color: const Color.fromARGB(255, 235, 233, 233),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
                  PdfWidget(seminar: seminar, scale: scale, images: images))),
    );
  }
}

class PdfWidget extends StatelessWidget {
  String seminar;
  double scale;
  List<Uint8List> images;
  final SeminarController scontroller = Get.put(SeminarController());
  final PdfController pdfcontroller = Get.put(PdfController());
  var flex = 25.obs;
  final TransformationController _controller = TransformationController();

  PdfWidget({required this.seminar, required this.scale, required this.images});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pdfcontroller.previewdrawertoggle.value
                    ? SizedBox(
                        width: 200,
                        height: MediaQuery.of(context).size.height,
                        child: PreviewDrawerPage(),
                      )
                    : SizedBox(width: 0),
                Expanded(
                    flex: 100 - flex.value,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 800),
                            child: PdfPage(
                              seminar: seminar,
                              scale: scale,
                              images: images,
                            )))),
                pdfcontroller.textdrawertoggle.value
                    ? MouseRegion(
                        cursor: SystemMouseCursors.grab,
                        child: GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              var dx = details.globalPosition.dx;
                              var result =
                                  ((dx / MediaQuery.of(context).size.width) *
                                          100)
                                      .toInt();
                              flex.value = 100 - result;
                            },
                            child: SizedBox(
                              width: 2,
                              child: Container(color: Colors.black12),
                            )))
                    : SizedBox(width: 0),
                pdfcontroller.textdrawertoggle.value
                    ? Expanded(
                        flex: flex.value,
                        child: TextPageDrawer(),
                      )
                    : SizedBox(width: 0),
              ],
            )),
      ],
    );
  }
}
