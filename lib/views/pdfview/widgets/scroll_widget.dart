import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:reading_league/views/homeview/screens/select_seminar_screen.dart';
import 'package:reading_league/views/homeview/screens/seminar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScrollButton extends StatelessWidget {
  final int imagecount;
  final double totalimageheight;
  var pagenumber = 1.obs;
  var isinputing = false.obs;

  final PdfController pdfcontroller = Get.put(PdfController());
  ScrollButton({required this.imagecount, required this.totalimageheight});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    return SizedBox(
      height: 101,
      width: 45,
      child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 定义圆角半径
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => isinputing.value
                    ? SizedBox(
                        width: 45,
                        height: 35,
                        child: Center(
                            child: TextField(
                          onSubmitted: (value) async {
                            pagenumber.value = int.parse(value);
                            await pdfcontroller.scrollController.animateTo(
                              ((pagenumber.value - 1) / imagecount) *
                                  totalimageheight,
                              duration: Duration(milliseconds: 500), // 持续时间
                              curve: Curves.ease,
                            );
                            isinputing.value = false;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '', // 空字符串，不显示 maxLength
                          ),
                          style: TextStyle(fontSize: 12),
                          maxLength: 3,
                          controller: _textEditingController,
                        )))
                    : SizedBox(
                        width: 45,
                        height: 35,
                        child: Center(
                          child: InkWell(
                              onTap: () => isinputing.value = true,
                              child: Text(pagenumber.value.toString(),
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 142, 139, 139)))),
                        ))),
                SizedBox(
                  width: 45,
                  height: 1,
                  child: Container(color: Colors.black12),
                ),
                SizedBox(
                    width: 45,
                    height: 35,
                    child: Center(
                        child: Text(
                      imagecount.toString(),
                      style: TextStyle(
                          fontSize: 11,
                          color: const Color.fromARGB(255, 142, 139, 139)),
                    ))),
              ])),
    );
  }
}
