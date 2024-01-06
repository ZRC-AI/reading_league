import 'dart:ui';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class TextEdit extends StatelessWidget {
  final BuildContext context;

  final TextController textcontroller = Get.put(TextController());
  final PdfController pdfcontroller = Get.put(PdfController());
  TextEdit(this.context);
  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController =
        TextEditingController(text: textcontroller.textcontent.value);

    return Obx(() => Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorHeight: 15,
                      onChanged: (value) =>
                          textcontroller.textcontent.value = value,
                      cursorWidth: 1.5,
                      cursorColor: Colors.black,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 14.0,
                      ),
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
                    '${textcontroller.textname.value}-编辑模式',
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
