import 'package:reading_league/views/homeview/screens/select_seminar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(800, 400),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: '',
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData greenTheme = ThemeData(
      primaryColor: Color.fromARGB(255, 110, 242, 114), // 设置应用程序的主要颜色// 设置强调颜色
      fontFamily: 'Roboto', // 设置默认字体
    );
    return GetMaterialApp(
        theme: greenTheme,
        home: Scaffold(
            body: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SelectSeminarScreen()))));
  }
}
