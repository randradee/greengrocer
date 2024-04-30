import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
