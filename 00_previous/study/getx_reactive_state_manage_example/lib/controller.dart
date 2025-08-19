import 'package:get/get.dart';
import 'package:getx_reactive_state_manage_example/model.dart';

// Controller
class Controller extends GetxController{

  final person = Person().obs; // obs: obserable

  void updateInfo() {
    person.update((val) {
      val?.age++;
      val?.name = "doyou";
    });
  }
}