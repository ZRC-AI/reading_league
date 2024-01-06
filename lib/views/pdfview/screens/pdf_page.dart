import 'dart:typed_data';

import 'package:reading_league/views/pdfview/screens/appbar.dart';
import 'package:reading_league/views/pdfview/widgets/pdf_image_widget.dart';
import 'package:reading_league/views/pdfview/widgets/preview_drawer_button.dart';
import 'package:reading_league/views/pdfview/widgets/scroll_widget.dart';
import 'package:reading_league/views/pdfview/widgets/text_drawer_button.dart';
import 'package:reading_league/views/pdfview/widgets/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/pdfview_controller/pdf_controller.dart';
import '../widgets/customslider.dart';
import '../widgets/paint_page.dart';
import '../widgets/audio_path_dialog.dart';

class PdfPage extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());
  String seminar;

  double scale;
  List<Uint8List> images;

  PdfPage({
    required this.seminar,
    required this.scale,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 800 * scale * images.length,
              child: CustomPdfPage(
                seminar: seminar,
                scale: scale,
                images: images,
              ))),
      Obx(() => pdfcontroller.showaudiopath.value
          ? Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.fromLTRB(350, 45, 0, 0),
                  child: AudioPathDialog()))
          : SizedBox()),
      Obx(() => pdfcontroller.canplaying.value
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Align(
                  alignment: Alignment.bottomCenter, child: CustomSlider()))
          : SizedBox()),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: CustomAppBar(seminar)))),
      pdfcontroller.textdrawertoggle.value
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Align(
                  alignment: Alignment.topRight, child: TextDrawerButton()))
          : SizedBox(),
      Align(alignment: Alignment.topLeft, child: PreviewDrawerbutton()),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Align(
              alignment: Alignment.bottomRight,
              child: ScrollButton(
                imagecount: images.length,
                totalimageheight: 800 * scale * images.length,
              ))),
    ]);
  }
}

class CustomPdfPage extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());
  String seminar;
  double scale;
  List<Uint8List> images;

  CustomPdfPage({
    required this.seminar,
    required this.scale,
    required this.images,
  });
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        minScale: 0.5,
        maxScale: 3.0,
        child: CustomScrollView(
            controller: pdfcontroller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: Stack(
                children: [
                  Center(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 800 * scale * images.length,
                    color: const Color.fromARGB(255, 235, 233, 233),
                  )),
                  Center(
                      child: SizedBox(
                          width: 800,
                          height: 800 * scale * images.length,
                          child: PdfImageWidget(
                            seminar: seminar,
                            images: images,
                            scale: scale,
                          ))),
                  IgnorePointer(
                      ignoring: false,
                      child: Center(
                          child: SizedBox(
                              width: 800,
                              height: 800 * scale * images.length,
                              child: PaintPage()))),
                  Center(
                      child: SizedBox(
                          width: 800,
                          height: 800 * scale * images.length,
                          child: TimeStampPage())),
                  // TextButtonPage(totalimageheight),
                  // ReferenceButtonPage(totalimageheight),
                ],
              )),
            ]));
  }
}
