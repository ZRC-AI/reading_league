import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_paths_controller.dart';
import 'package:reading_league/views/homeview/screens/select_seminar_screen.dart';
import 'package:reading_league/views/homeview/screens/seminar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewDrawerbutton extends StatelessWidget {
  final PdfController pdfcontroller = Get.put(PdfController());
  final TextController textcontroller = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 260, maxWidth: 45),
      child: Obx(() => Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // 定义圆角半径
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
                iconSize: 16.0,
                splashRadius: 16.0,
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                )),
            IconButton(
                iconSize: 18.0,
                splashRadius: 16.0,
                onPressed: () {
                  if (pdfcontroller.previewdrawertoggle.value == false) {
                    pdfcontroller.previewdrawerstate.value =
                        PreviewDrawerState.imagepreviews;
                    pdfcontroller.previewdrawertoggle.value = true;
                  } else {
                    if (pdfcontroller.previewdrawerstate.value !=
                        PreviewDrawerState.imagepreviews) {
                      pdfcontroller.previewdrawerstate.value =
                          PreviewDrawerState.imagepreviews;
                    } else {
                      pdfcontroller.previewdrawertoggle.value = false;
                    }
                  }
                },
                icon: Icon(
                  color: pdfcontroller.previewdrawertoggle.value &&
                          pdfcontroller.previewdrawerstate.value ==
                              PreviewDrawerState.imagepreviews
                      ? Color.fromARGB(255, 108, 205, 111)
                      : null,
                  Icons.image,
                )),
            IconButton(
                iconSize: 18.0,
                splashRadius: 16.0,
                onPressed: () {
                  if (pdfcontroller.previewdrawertoggle.value == false) {
                    pdfcontroller.previewdrawerstate.value =
                        PreviewDrawerState.textpreviews;
                    pdfcontroller.previewdrawertoggle.value = true;
                  } else {
                    if (pdfcontroller.previewdrawerstate.value !=
                        PreviewDrawerState.textpreviews) {
                      pdfcontroller.previewdrawerstate.value =
                          PreviewDrawerState.textpreviews;
                    } else {
                      pdfcontroller.previewdrawertoggle.value = false;
                    }
                  }
                },
                icon: Icon(
                  Icons.pageview,
                  color: pdfcontroller.previewdrawertoggle.value &&
                          pdfcontroller.previewdrawerstate.value ==
                              PreviewDrawerState.textpreviews
                      ? Color.fromARGB(255, 158, 237, 161)
                      : null,
                )),
            IconButton(
                iconSize: 18.0,
                splashRadius: 16.0,
                onPressed: () {
                  textcontroller.createtext(context);
                },
                icon: const Icon(
                  Icons.note_add,
                )),
            textcontroller.textname != ''
                ? IconButton(
                    iconSize: 18.0,
                    splashRadius: 16.0,
                    onPressed: () {
                      pdfcontroller.textdrawertoggle.value =
                          !pdfcontroller.textdrawertoggle.value;
                    },
                    icon: Icon(
                      Icons.note,
                      color: pdfcontroller.textdrawertoggle.value
                          ? Color.fromARGB(255, 108, 205, 111)
                          : null,
                    ))
                : SizedBox(),
            GestureDetector(
                onTapDown: (detail) async {
                  await showMenu(
                      context: context,
                      elevation: 10.0,
                      color: Color.fromARGB(255, 241, 239, 239),
                      constraints: BoxConstraints(
                          minWidth: 80,
                          maxWidth: 100,
                          maxHeight: 200,
                          minHeight: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      position: RelativeRect.fromLTRB(
                          detail.globalPosition.dx,
                          detail.globalPosition.dy,
                          detail.globalPosition.dx,
                          detail.globalPosition.dy),
                      items: <PopupMenuItem<String>>[
                        const PopupMenuItem<String>(
                          height: 30,
                          value: 'item1',
                          child: Text('导入图片', style: TextStyle(fontSize: 14)),
                        ),
                        const PopupMenuItem<String>(
                          height: 30,
                          value: 'item2',
                          child: Text('导入笔记', style: TextStyle(fontSize: 14)),
                        ),
                        // const PopupMenuItem<String>(
                        //   height: 30,
                        //   value: 'item3',
                        //   child:
                        //       Text('向前调整20s', style: TextStyle(fontSize: 14)),
                        // ),
                        // const PopupMenuItem<String>(
                        //   height: 30,
                        //   value: 'item4',
                        //   child:
                        //       Text('向后调整20s', style: TextStyle(fontSize: 14)),
                        // ),
                        // const PopupMenuItem<String>(
                        //   height: 30,
                        //   value: 'item5',
                        //   child: Text('修改注释', style: TextStyle(fontSize: 14)),
                        // ),
                        // const PopupMenuItem<String>(
                        //   height: 30,
                        //   value: 'item6',
                        //   child: Text(
                        //     '删除',
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        // ),
                      ]).then((value) async {
                    if (value != null) {
                      // 处理选定的菜单项
                      if (value == 'item2') {
                        await textcontroller.inserttextpath();
                      } else if (value == 'item1') {
                        await textcontroller.insertimagepath();
                      }

                      // else if (value == 'item3') {
                      //   await abcontroller.updateButtonTime(-20, button.id,
                      //       button.seminar, button.stamp.inSeconds);
                      // } else if (value == 'item4') {
                      //   await abcontroller.updateButtonTime(20, button.id,
                      //       button.seminar, button.stamp.inSeconds);
                      // } else if (value == 'item5') {
                      //   //修改注释
                      // } else if (value == 'item6') {
                      //   await abcontroller.deleteButton(
                      //       button.id, button.seminar);
                      // }
                    }
                  });
                },
                child: Icon(
                  FontAwesomeIcons.ellipsis,
                  size: 18,
                )),
            SizedBox(
              height: 10,
            )
          ]))),
    );
  }
}
