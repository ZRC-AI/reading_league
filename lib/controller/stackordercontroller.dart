import 'package:get/get.dart';

class StackOrderController extends GetxController {
  var paindex = 0.obs;

  void paintchange() {
    paindex.value = 0;
  }

  void penchange() {
    paindex.value = 1;
  }
}
