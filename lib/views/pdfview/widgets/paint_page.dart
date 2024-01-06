import 'dart:ui';

import 'package:reading_league/model/paint_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/pdfview_controller/drawing_controller.dart';

class PaintPage extends StatelessWidget {
  final DrawingController dController = Get.put(DrawingController());
  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (PointerDownEvent event) {
          dController.startDrawing(
              context, event.localPosition, dController.canDrawing.value);
        },
        onPointerMove: (PointerMoveEvent event) {
          dController.addPoint(context, event.localPosition,
              dController.canDrawing.value // 在绘制结束时添加一个空点以分隔不同的笔画
              );
        },
        onPointerUp: (PointerUpEvent event) {
          dController.stopDrawing(dController.canDrawing.value);
        },
        child: GetBuilder<DrawingController>(
          init: DrawingController(),
          builder: (DrawingController controller) {
            return CustomPaint(
              isComplex: true,
              painter: MyPainter(controller.paths, controller.newpath),
              willChange: true,
            );
          },
        ));
  }
}

class MyPainter extends CustomPainter {
  final List<Paintpaths> paths;
  final List<Offset> newpath;
  MyPainter(this.paths, this.newpath);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Color.fromARGB(50, 243, 227, 7)
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 20.0;
    Paint eraser = Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 20.0;
    for (Paintpaths path in paths) {
      for (int i = 0; i < path.paths.length - 1; i++) {
        canvas.drawLine(path.paths[i], path.paths[i + 1], paint1);
      }
    }
    for (int i = 0; i < newpath.length - 1; i++) {
      if (DrawingController.to.eraser.value) {
        canvas.drawLine(newpath[i], newpath[i + 1], eraser);
      } else {
        canvas.drawLine(newpath[i], newpath[i + 1], paint1);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
