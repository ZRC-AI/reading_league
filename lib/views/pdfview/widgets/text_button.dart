import 'dart:ffi';

import 'package:reading_league/controller/pdfview_controller/audio_paths_controller.dart';
import 'package:reading_league/controller/pdfview_controller/text_button_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/pdfview_controller/audio_button_controller.dart';

class TextButtonPage extends StatelessWidget {
  final TextButtonController tbcontroller = Get.put(TextButtonController());
  @override
  Widget build(BuildContext context) {
    tbcontroller.tbcontext = context;
    return Obx(
      () => Stack(
          children: tbcontroller.textbuttons.map((button) {
        return Positioned(
          right: 0,
          top: button.position.dy,
          child: Draggable(
              feedback: TextButton(
                onPressed: () {},
                child: Text(
                  '${button.name}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                final RenderBox positionedRenderBox =
                    context.findRenderObject() as RenderBox;
                final localOffset =
                    positionedRenderBox.globalToLocal(details.offset);
                tbcontroller.updatetb(button, localOffset);
              },
              child: GestureDetector(
                  onSecondaryTapDown: (detail) async {
                    await showMenu(
                        context: context,
                        elevation: 10.0,
                        color: Color.fromARGB(255, 241, 239, 239),
                        constraints: BoxConstraints(
                            minWidth: 100,
                            maxWidth: 150,
                            maxHeight: 200,
                            minHeight: 90),
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
                          // const PopupMenuItem<String>(
                          //   height: 30,
                          //   value: 'item1',
                          //   child: Text('向前调整5s',
                          //       style: TextStyle(fontSize: 14)),
                          // ),
                          // const PopupMenuItem<String>(
                          //   height: 30,
                          //   value: 'item2',
                          //   child: Text('向后调整5s',
                          //       style: TextStyle(fontSize: 14)),
                          // ),
                          // const PopupMenuItem<String>(
                          //   height: 30,
                          //   value: 'item3',
                          //   child: Text('向前调整20s',
                          //       style: TextStyle(fontSize: 14)),
                          // ),
                          // const PopupMenuItem<String>(
                          //   height: 30,
                          //   value: 'item4',
                          //   child: Text('修改命名', style: TextStyle(fontSize: 14)),
                          // ),
                          // const PopupMenuItem<String>(
                          //   height: 30,
                          //   value: 'item5',
                          //   child: Text('修改注释', style: TextStyle(fontSize: 14)),
                          // ),
                          const PopupMenuItem<String>(
                            height: 30,
                            value: 'item6',
                            child: Text(
                              '删除',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ]).then((value) async {
                      if (value != null) {
                        // 处理选定的菜单项
                        // if (value == 'item1') {
                        //   await tbcontroller.updateButtonTime(-5, button.id,
                        //       button.seminar, button.stamp.inSeconds);
                        // } else if (value == 'item2') {
                        //   await abcontroller.updateButtonTime(5, button.id,
                        //       button.seminar, button.stamp.inSeconds);
                        // } else if (value == 'item3') {
                        //   await abcontroller.updateButtonTime(
                        //       -20,
                        //       button.id,
                        //       button.seminar,
                        //       button.stamp.inSeconds);
                        // }
                        // else if (value == 'item4') {
                        //   await tbcontroller.update(20, button.id,
                        //       button.seminar, button.stamp.inSeconds);
                        // }
                        // if (value == 'item5') {
                        //   await tbcontroller.update();
                        // } else
                        if (value == 'item6') {
                          await tbcontroller.deletebt(button);
                        }
                      }
                    });
                  },
                  onTap: () {
                    // 请更改
                    // tbcontroller.seektoplay(
                    //     button.name, button.seminar, button.stamp);
                    // tbcontroller.isplayingaudio = button.name;
                  },
                  child: Card(
                    elevation: 1,
                    color: const Color.fromARGB(255, 170, 243, 172),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 20),
                        child: Row(children: [
                          Icon(
                            FontAwesomeIcons.notdef,
                            size: 12,
                          ),
                          Text(
                            '${button.path}',
                            style: TextStyle(fontSize: 12),
                          )
                        ])),
                  ))),
        ); // 传递正确的上下文
      }).toList()),
    );
  }
}
