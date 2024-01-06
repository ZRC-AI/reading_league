// import 'dart:io';

// import 'package:audio_4/controller/project_controller/project_controller.dart';
// import 'package:audio_4/model/project_class.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CreateProjectScreen extends StatelessWidget {
//   final ProjectController controller = Get.put(ProjectController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create New Project'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Select a PDF file:'),
//             Obx(() {
//               return ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? results =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.any, // 指定文件类型，这里使用自定义类型以便选择多个文件
//                     allowedExtensions: ['pdf'], // 允许的文件扩展名，例如只允许选择PDF文件
//                     allowMultiple: true, // 允许选择多个文件
//                   );

//                   if (results != null) {
//                     controller.selectedPdfFile.value =
//                         File(result.files.single.path!);
//                   }
//                 },
//                 child: Text('Choose PDF File'),
//               );
//             }),
//             SizedBox(height: 16.0),
//             Text('Project Name:'),
//             TextField(
//               onChanged: (value) {
//                 controller.projectName.value = value;
//               },
//             ),
//             SizedBox(height: 16.0),
//             Text('Project Description:'),
//             TextField(
//               onChanged: (value) {
//                 controller.projectDescription.value = value;
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 controller.pickAndCreateProjectFolder();
//               },
//               child: Text('Create Project'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProjectDetailsScreen extends StatelessWidget {
//   final Project project;

//   ProjectDetailsScreen({required this.project});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Project Name: ${project.name}'),
//             Text('Project Description: ${project.description}'),
//             SizedBox(height: 16.0),
//             Text('File Libraries:'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: project.fileLibraries
//                   .map((library) => Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(library.name),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: library.files
//                                 .map((file) => Text(file.path))
//                                 .toList(),
//                           ),
//                           SizedBox(height: 16.0),
//                         ],
//                       ))
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
