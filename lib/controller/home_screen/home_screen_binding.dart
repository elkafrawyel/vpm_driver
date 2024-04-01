import 'package:get/instance_manager.dart';

import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
