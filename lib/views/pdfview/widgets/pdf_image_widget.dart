import 'dart:typed_data';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfImageWidget extends StatelessWidget {
  final String seminar;
  final double scale;
  final List<Uint8List> images;

  PdfImageWidget(
      {required this.seminar, required this.images, required this.scale});

  final PdfController pdfcontroller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 228, 228, 228),
        child: Column(
            children: images
                .map((e) => Container(
                      color: Colors.white,
                      child: Image.memory(
                          width: MediaQuery.of(context).size.width, e),
                    ))
                .toList()));
  }
}
