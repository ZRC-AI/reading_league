import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class PdfPreviews extends StatelessWidget {
  final TextController textcontroller = Get.put(TextController());
  final PdfController pdfcontroller = Get.put(PdfController());
  var isselected = <bool>[].obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: textcontroller.textpaths.length,
                itemBuilder: (context, index) {
                  isselected.add(false);
                  // return FutureBuilder(
                  //   future:
                  //       textcontroller.gettext(textcontroller.textpaths[index]),
                  //   builder:
                  //       (BuildContext context, AsyncSnapshot<String> snapshot) {
                  //     isselected.add(false);
                  //     return MouseRegion(
                  //         onEnter: (event) {
                  //           isselected[index] = true;
                  //         },
                  //         onExit: (event) {
                  //           isselected[index] = false;
                  //         },
                  //         child: SizedBox(
                  //             width: 120,
                  //             height: 120 * 1.1412,
                  //             child: Obx(() => Container(
                  //                 decoration: BoxDecoration(
                  //                     color: isselected[index]
                  //                         ? Colors.black12
                  //                         : Colors.red),
                  //                 child: Column(children: [
                  //                   Spacer(),
                  //                   SizedBox(
                  //                       width: 70,
                  //                       height: 70 * 1.1412,
                  //                       child: Markdown(
                  //                           data: '1121122',
                  //                           shrinkWrap: true, // 缩小以适应内容
                  //                           physics: ClampingScrollPhysics())),
                  //                   SizedBox(
                  //                       width: 150,
                  //                       child: Text(
                  //                         '${textcontroller.textpaths[index].path.split('.')[0]}',
                  //                         style: TextStyle(fontSize: 14),
                  //                       ))
                  //                 ])))));
                  //   },
                  // );
                }))
      ],
    );
  }
}
