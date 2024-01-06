import 'dart:io';

import 'package:reading_league/views/homeview/screens/seminar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/project_controller/seminar_controller.dart';

class CreateProjectScreen extends StatelessWidget {
  final SeminarController scontroller = Get.put(SeminarController());
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  final TextEditingController textField3Controller = TextEditingController();
  final List<File> selectedFiles;
  CreateProjectScreen({required this.selectedFiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Field 1:'),
            TextField(
              controller: textField1Controller,
            ),
            SizedBox(height: 16.0),
            Text('Field 2:'),
            TextField(
              controller: textField2Controller,
            ),
            SizedBox(height: 16.0),
            Text('Field 3:'),
            TextField(
              controller: textField3Controller,
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // 执行提交操作
                    String name = textField1Controller.text;
                    String initiator = textField2Controller.text;
                    String description = textField3Controller.text;
                    // 在这里执行提交逻辑，可以将这些值发送到服务器或其他操作
                    textField1Controller.clear();
                    textField2Controller.clear();
                    textField3Controller.clear();

                    await scontroller.pickAndCreateProjectFolder(
                        name, initiator, description, selectedFiles);
                  },
                  child: Text('Commit'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // 执行取消操作
                    textField1Controller.clear();
                    textField2Controller.clear();
                    textField3Controller.clear();
                    Get.to(homescreen());
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
