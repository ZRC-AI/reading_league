import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/project_controller/seminar_controller.dart';
import 'package:reading_league/views/homeview/widgets/project_button.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SelectSeminarScreen extends StatelessWidget {
  final SeminarController scontroller = Get.put(SeminarController());
  final PdfController pdfController = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var newisselected = [false].obs;
    return SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Container(
          color: Colors.white,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
                width: screenWidth,
                height: 26,
                child: Container(
                    color: const Color.fromARGB(255, 237, 255, 233),
                    child: const Center(
                        child: Text(
                      'Seminar Start',
                      style: TextStyle(fontSize: 13),
                    )))),
            SizedBox(
              height: 1,
              width: screenWidth,
              child: Container(color: Colors.black12),
            ),
            SizedBox(
                width: screenWidth,
                height: 70,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    color: const Color.fromARGB(255, 242, 242, 242),
                    child: ProjectButton())),
            SizedBox(
              height: 1,
              width: screenWidth,
              child: Container(color: Colors.black12),
            ),
            Expanded(
                child: Obx(() => Container(
                    padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                    child: ListView.builder(
                      itemCount: scontroller.seminars.length,
                      itemExtent: 75,
                      itemBuilder: (context, index) {
                        newisselected.add(false);
                        return MouseRegion(
                          onEnter: (event) {
                            newisselected[index] = true;
                          },
                          onExit: (event) {
                            newisselected[index] = false;
                          },
                          child: Obx(() => Card(
                              elevation: 0,
                              color: newisselected[index]
                                  ? const Color.fromARGB(255, 180, 249, 189)
                                  : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      width: 42,
                                      height: 42,
                                      child: Card(
                                          color: const Color.fromARGB(
                                              255, 109, 202, 121),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(scontroller
                                                  .seminars[index].name
                                                  .substring(0, 1)
                                                  .toUpperCase())))),
                                  Expanded(
                                      child: ListTile(
                                          title: Text(
                                              '${scontroller.seminars[index].name}'),
                                          subtitle: Text(
                                              'initiator:${scontroller.seminars[index].initiator}'),
                                          onTap: () async {
                                            pdfController.topdfview(scontroller
                                                .seminars[index].name);
                                          })),
                                  SizedBox(
                                      height: 42,
                                      width: 42,
                                      child: IconButton(
                                        splashRadius: 18,
                                        onPressed: () async {
                                          await scontroller.exportSeminar(
                                              scontroller.seminars[index]);
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.fileExport,
                                            size: 14),
                                      )),
                                  SizedBox(
                                      height: 42,
                                      width: 42,
                                      child: IconButton(
                                        splashRadius: 18,
                                        onPressed: () async {
                                          await scontroller.deleteSeminar(
                                              scontroller.seminars[index]);
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.trash,
                                          size: 14,
                                        ),
                                      )),
                                ],
                              ))),
                        );
                      },
                    ))))
          ]),
        ));
  }
}
