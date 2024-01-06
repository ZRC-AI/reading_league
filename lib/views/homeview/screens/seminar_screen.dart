import 'dart:io';
import 'package:reading_league/controller/project_controller/seminar_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'create_seminar_screen.dart';

class homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SeminarController scontroller = Get.put(SeminarController());
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 255, 255), // 设置容器的背景颜色
        borderRadius: BorderRadius.circular(30.0), // 设置圆角
      ),
      child: Align(
          alignment: Alignment.center,
          child: Column(children: [
            Spacer(),
            SizedBox(
                width: 350,
                height: 70,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 设置圆角半径
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 按下状态下的背景颜色
                            return Color.fromARGB(255, 128, 128, 128);
                          }
                          // 正常状态下的背景颜色
                          return Color.fromARGB(255, 128, 128, 128);
                        },
                      ),
                    ),
                    onPressed: () async {
                      scontroller.selectSeminar();
                    },
                    child: Text('打开已有项目',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 255, 255))))),
            Spacer(),
            SizedBox(
                width: 350,
                height: 70,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 设置圆角半径
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 按下状态下的背景颜色
                            return Color.fromARGB(255, 128, 128, 128);
                          }
                          // 正常状态下的背景颜色
                          return Color.fromARGB(255, 128, 128, 128);
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text('导入已有项目',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 255, 255))))),
            Spacer(),
            SizedBox(
                width: 350,
                height: 70,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // 设置圆角半径
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 按下状态下的背景颜色
                            return Color.fromARGB(255, 128, 128, 128);
                          }
                          // 正常状态下的背景颜色
                          return Color.fromARGB(255, 128, 128, 128);
                        },
                      ),
                    ),
                    onPressed: () async {
                      FilePickerResult? results =
                          await FilePicker.platform.pickFiles(
                        type: FileType.any, // 指定文件类型，这里使用自定义类型以便选择多个文件
                        allowedExtensions: ['pdf'], // 允许的文件扩展名，例如只允许选择PDF文件
                        allowMultiple: true, // 允许选择多个文件
                      );
                      if (results != null) {
                        List<File> selectedFiles = results.files
                            .map((file) => File(file.path!))
                            .toList();
                        Get.to(
                            CreateProjectScreen(selectedFiles: selectedFiles));
                      }
                    },
                    child: Text('创建新项目',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 0, 255, 255))))),
            Spacer(),
          ])),
    );
  }
}
