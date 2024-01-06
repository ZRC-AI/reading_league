import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Controller for picking and managing files in a Flutter app.
class FilePickerController extends GetxController {
  /// Opens a file picker dialog to allow the user to select and save a file.
  ///
  /// This function uses the `file_picker` library to show a file picker dialog,
  /// allowing the user to select a file. If the selected file has the '.pdf' extension,
  /// it is copied to the application's document directory.
  /// If the selected file does not have the '.pdf' extension, a warning message is displayed.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// FilePickerController fileController = FilePickerController();
  /// await fileController.pickAndSaveFile();
  /// ```
  ///
  /// Note: This function assumes that the `path_provider` library is imported
  /// and used to obtain the application's document directory.
  ///
  /// See also:
  ///
  /// - [FilePickerResult] class from the `file_picker` library for file selection result details.
  static Future<void> pickAndSaveFileAndCreateDirectory() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      String fileExtension = path.extension(filePath).toLowerCase();
      // Check the file extension
      if (fileExtension == '.pdf') {
        // Handle the PDF file logic here
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String destinationPath =
            path.join(documentsDirectory.path, 'selected_file.pdf');
        File sourceFile = File(filePath);
        await sourceFile.copy(destinationPath);
      } else {
        // If the file is not of the required type, display a warning message
        Get.snackbar(
          'Warning',
          'Invalid file type. Only .txt files are allowed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // User canceled the file selection
    }
  }

  /// Opens a file picker dialog to allow the user to select a file.
  ///
  /// This function uses the `file_picker` library to show a file picker dialog,
  /// allowing the user to select a file. The result is stored in the [filePickerResult] property.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// FilePickerController fileController = FilePickerController();
  /// await fileController.pickFile();
  /// // Access the selected file result using: fileController.filePickerResult.value
  /// ```

  static Future<List<String>> pickImageFiles(bool allowMultiple) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: allowMultiple);
    List<String> filePaths = [];

    if (result != null) {
      for (PlatformFile file in result.files) {
        filePaths.add(file.path!);
      }
    }
    return filePaths;
  }

  static Future<List<String>> pickTextFiles(bool allowMultiple) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'md'],
        allowMultiple: allowMultiple);
    List<String> filePaths = [];

    if (result != null) {
      for (PlatformFile file in result.files) {
        filePaths.add(file.path!);
      }
    }

    return filePaths;
  }
}
