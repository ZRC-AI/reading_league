import 'dart:typed_data';

import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as i;
import 'package:reading_league/model/text.dart' as text;

import 'package:flutter_markdown/flutter_markdown.dart';

class ImagePreviews extends StatelessWidget {
  final TextController imagecontroller = Get.put(TextController());
  final PdfController pdfcontroller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 230, 230, 230),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ColumnBuilder(),
            )))
          ],
        ));
  }
}

class ColumnBuilder extends StatelessWidget {
  final TextController textcontroller = Get.put(TextController());
  var isselected = <bool>[].obs;

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    for (int index = 0; index < textcontroller.imagepaths.length; index++) {
      isselected.add(false);
      widgets.add(SizedBox(
          height: 140 * 1.4,
          width: 140,
          child: FutureBuilder(
            future: textcontroller.showimage(
                null, textcontroller.imagepaths[index]),
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              isselected.add(false);
              return MouseRegion(
                  onEnter: (event) {
                    isselected[index] = true;
                  },
                  onExit: (event) {
                    isselected[index] = false;
                  },
                  child: InkWell(
                      onTap: () {
                        textcontroller.textcontent.value = textcontroller
                                .textcontent.value +
                            '![${textcontroller.imagepaths[index].path.split('.')[0]}](${textcontroller.imagepaths[index].path})';
                      },
                      child: SizedBox(
                          width: 140,
                          height: 120 * 1.1412,
                          child: Card(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              color: isselected[index]
                                  ? Color.fromARGB(249, 227, 227, 227)
                                  : null,
                              elevation: 4,
                              child: SizedBox(
                                  width: 140,
                                  height: 120 * 1.1412,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                            width: 140,
                                            height: 120 * 1.1412,
                                            child: Image(
                                              width: 200,
                                              image:
                                                  MemoryImage(snapshot.data!),
                                            )),
                                        SizedBox(
                                            width: 140,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '${textcontroller.imagepaths[index].path.split('.')[0]}',
                                              style: TextStyle(fontSize: 12),
                                            ))
                                      ]))))));
            },
          )));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: widgets,
    );
  }
}
