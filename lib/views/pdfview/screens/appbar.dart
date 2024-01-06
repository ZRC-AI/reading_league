import 'dart:ffi';

import 'package:reading_league/controller/pdfview_controller/audio_button_controller.dart';
import 'package:reading_league/controller/pdfview_controller/audio_paths_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/pdfview_controller/record_controller.dart';

import '../../../controller/pdfview_controller/drawing_controller.dart';

import '../../../controller/pdfview_controller/pdf_controller.dart';

class CustomAppBar extends StatelessWidget {
  var isrecording = false.obs;
  var ispausing = true.obs;
  String seminar;
  var recordingname = ''.obs;

  CustomAppBar(this.seminar);

  @override
  Widget build(BuildContext context) {
    final RecordController rcontroller = Get.put(RecordController());
    final AudioPathsController apscontroller = Get.put(AudioPathsController());
    final AudioButtonController abcontroller = Get.put(AudioButtonController());
    final PdfController pdfcontroller = Get.put(PdfController());

    return Obx(() => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // 定义圆角半径
        ),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: 18.0,
                iconSize: 17,
                onPressed: () {
                  DrawingController.to.eraser.value = false;
                  DrawingController.to.canDrawing.value =
                      !DrawingController.to.canDrawing.value;
                },
                color: DrawingController.to.canDrawing.value
                    ? Colors.red
                    : Colors.black,
                icon: Icon(FontAwesomeIcons.paintbrush)),
            IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 17,
                splashRadius: 18.0,
                onPressed: () {
                  DrawingController.to.eraser.value =
                      !DrawingController.to.eraser.value;
                  DrawingController.to.canDrawing.value = false;
                },
                color: DrawingController.to.eraser.value
                    ? Colors.red
                    : Colors.black,
                icon: Icon(FontAwesomeIcons.eraser)),
            IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 17,
                splashRadius: 18.0,
                onPressed: () {
                  DrawingController.to.eraser.value = false;
                  DrawingController.to.canDrawing.value = false;
                },
                color: Colors.black,
                icon: Icon(
                  FontAwesomeIcons.textWidth,
                )),
            isrecording.value
                ? ispausing.value
                    ? Stack(children: [
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${(rcontroller.recordingseconds.value / 60).floor()}:${rcontroller.recordingseconds.value % 60}',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color: Color.fromARGB(255, 97, 224, 102)),
                                ))),
                        IconButton(
                            visualDensity: VisualDensity.compact,
                            iconSize: 17,
                            splashRadius: 18.0,
                            onPressed: () {
                              rcontroller.resume();
                              ispausing.value = false;
                            },
                            color: Colors.black,
                            icon: Icon(FontAwesomeIcons.circlePlay)),
                      ])
                    : Stack(children: [
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${(rcontroller.recordingseconds.value / 60).floor()}:${rcontroller.recordingseconds.value % 60}',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color: Color.fromARGB(255, 97, 224, 102)),
                                ))),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          iconSize: 17,
                          splashRadius: 18.0,
                          onPressed: () {
                            rcontroller.pause();
                            ispausing.value = true;
                          },
                          color: Colors.black,
                          icon: Icon(FontAwesomeIcons.circlePause),
                        )
                      ])
                : IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 17,
                    splashRadius: 18.0,
                    onPressed: () async {
                      recordingname.value = await rcontroller.start(seminar);
                      isrecording.value = true;
                      ispausing.value = false;
                    },
                    color: Colors.black,
                    icon: Icon(FontAwesomeIcons.microphone)),
            isrecording.value
                ? IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 17,
                    splashRadius: 18.0,
                    onPressed: () {
                      rcontroller.stop(seminar);
                      isrecording.value = false;
                    },
                    color: Colors.black,
                    icon: Icon(FontAwesomeIcons.hourglassEnd))
                : SizedBox(),
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 17,
              splashRadius: 18.0,
              onPressed: () {
                pdfcontroller.showaudiopath.value =
                    !(pdfcontroller.showaudiopath.value);
              },
              color: Colors.black,
              icon: Icon(FontAwesomeIcons.fileAudio),
            ),
            (isrecording.value || pdfcontroller.canplaying.value) &&
                    (!isrecording.value || !pdfcontroller.canplaying.value)
                ? IconButton(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    iconSize: 17,
                    splashRadius: 18.0,
                    onPressed: () {
                      isrecording.value
                          ? abcontroller.addrecordButton(
                              stamp: rcontroller.recordingseconds.value,
                              name: recordingname.value,
                              seminar: seminar,
                            )
                          : abcontroller.addplayingButton(
                              stamp: abcontroller.position!.inSeconds,
                              name: apscontroller.isplayingaudio!,
                              seminar: seminar);
                    },
                    icon: Icon(FontAwesomeIcons.timeline))
                : SizedBox()
          ],
        )));
  }
}
