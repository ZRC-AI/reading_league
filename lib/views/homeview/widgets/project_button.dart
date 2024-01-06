import 'dart:io';
import 'package:reading_league/controller/project_controller/seminar_controller.dart';
import 'package:reading_league/views/homeview/screens/create_seminar_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectButton extends StatelessWidget {
  final SeminarController scontroller = Get.put(SeminarController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(
            child: TextField(
          decoration: InputDecoration(
            hintText: '搜索...',
            prefixIcon: Icon(Icons.search),
          ),
        )),
        Row(children: [
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 2,
              ),
              onPressed: () async {
                FilePickerResult? results = await FilePicker.platform.pickFiles(
                  type: FileType.any, // 指定文件类型，这里使用自定义类型以便选择多个文件
                  allowedExtensions: ['pdf'], // 允许的文件扩展名，例如只允许选择PDF文件
                  allowMultiple: false, // 允许选择多个文件
                );
                if (results != null) {
                  List<File> selectedFiles =
                      results.files.map((file) => File(file.path!)).toList();
                  Get.to(CreateProjectScreen(selectedFiles: selectedFiles));
                }
              },
              child: const Row(children: [
                Icon(
                  FontAwesomeIcons.book,
                  size: 14,
                ),
                SizedBox(width: 7),
                Text('create')
              ])),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 2,
              ),
              onPressed: () async {
                await scontroller.importSeminar();
              },
              child: const Row(children: [
                Icon(
                  Icons.folder_rounded,
                  size: 14,
                ),
                SizedBox(width: 7),
                Text('import')
              ])),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 2,
              ),
              onPressed: () {},
              child: const Row(children: [
                Icon(
                  FontAwesomeIcons.codePullRequest,
                  size: 14,
                ),
                SizedBox(width: 7),
                Text('pull')
              ])),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 2,
              ),
              onPressed: () {},
              child: const Row(children: [
                Icon(
                  FontAwesomeIcons.pushed,
                  size: 14,
                ),
                SizedBox(width: 7),
                Text('push')
              ])),
          const SizedBox(
            width: 10,
          ),
        ]),
      ],
    );
  }
}
