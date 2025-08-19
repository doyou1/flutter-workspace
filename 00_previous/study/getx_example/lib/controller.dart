import 'package:get/get.dart';

class Controller extends GetxController{
  int _x = 0;
  int get x => _x;

  void increment() {
    ++_x;
    // update method를 호출해야 변화를 감지 및 표시함
    update();
  }
}