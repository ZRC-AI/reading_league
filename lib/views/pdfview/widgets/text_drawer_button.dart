import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:reading_league/views/homeview/screens/seminar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextDrawerButton extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());
  final TextController textcontroller = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 45),
      child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 定义圆角半径
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
                child: Semantics(
                    label: '编辑',
                    child: IconButton(
                        iconSize: 18.0,
                        splashRadius: 16.0,
                        onPressed: () async {
                          if (pdfcontroller.textdrawerstate.value !=
                              TextDrawerState.edit) {
                            pdfcontroller.textdrawerstate.value =
                                TextDrawerState.edit;
                          } else {
                            pdfcontroller.textdrawertoggle.value = false;
                          }
                        },
                        icon: Icon(
                          Icons.note_alt,
                        )))),
            InkWell(
                child: Semantics(
                    label: '保存并预览',
                    child: IconButton(
                        iconSize: 18.0,
                        splashRadius: 16.0,
                        onPressed: () async {
                          await textcontroller.savetext();
                          if (pdfcontroller.textdrawerstate.value !=
                              TextDrawerState.preview) {
                            pdfcontroller.textdrawerstate.value =
                                TextDrawerState.preview;
                          } else {
                            pdfcontroller.textdrawertoggle.value = false;
                          }
                        },
                        icon: Icon(
                          Icons.search,
                        )))),
          ])),
    );
  }
}
