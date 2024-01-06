import 'package:reading_league/controller/pdfview_controller/audio_button_controller.dart';
import 'package:reading_league/controller/pdfview_controller/audio_paths_controller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AudioPathDialog extends StatelessWidget {
  final AudioPathsController apscontroller = Get.put(AudioPathsController());
  final PdfController pdfcontroller = Get.put(PdfController());
  final AudioButtonController abcontroller = Get.put(AudioButtonController());

  @override
  Widget build(BuildContext context) {
    var isselected = [false].obs;
    return Obx(() => ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: 350, maxWidth: 250, minHeight: 270, minWidth: 200),
        child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // 定义圆角半径
            ),
            elevation: 6,
            color: Color.fromARGB(245, 255, 255, 255),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
              child: ListView.builder(
                itemCount: apscontroller.audiopaths.length,
                itemBuilder: (context, index) {
                  isselected.add(false);
                  return MouseRegion(
                    onEnter: (event) {
                      isselected[index] = true;
                    },
                    onExit: (event) {
                      isselected[index] = false;
                    },
                    child: Card(
                      // // Container(
                      //decoration: BoxDecoration(
                      // //     color: isselected[index]
                      // //         ? Color.fromARGB(255, 224, 226, 228)
                      // //         : Color.fromARGB(255, 255, 255, 255),
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     border: Border.all(
                      //       color: Colors.black12, // 边框颜色
                      //       width: 0.5,
                      //     )),
                      elevation: 2,
                      child: ListTile(
                          title: Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: 110,
                          child: TextButton(
                            child: Text(
                                '${apscontroller.audiopaths[index].path.split('.')[0]}'),
                            onPressed: () {
                              pdfcontroller.canplaying.value = true;
                              apscontroller.isplayingaudio =
                                  apscontroller.audiopaths[index].path;
                              abcontroller.audioplaypausing.value = true;
                              pdfcontroller.showaudiopath.value = false;
                              abcontroller.seektoplay(
                                  apscontroller.audiopaths[index].path,
                                  pdfcontroller.seminar!,
                                  Duration.zero);
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            apscontroller.rename(
                                apscontroller.audiopaths[index], context);
                          },
                          icon: Icon(Icons.book),
                          iconSize: 16,
                          splashRadius: 17,
                        ),
                        IconButton(
                          onPressed: () {
                            apscontroller.deleteaudio(
                                apscontroller.audiopaths[index], context);
                          },
                          icon: Icon(Icons.delete),
                          iconSize: 16,
                          splashRadius: 17,
                        )
                      ])),
                    ),
                  );
                },
              ),
            ))));
  }
}
