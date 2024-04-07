import 'package:driver/controller/home_screen/history_controller.dart';
import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:driver/controller/home_screen/requests_controller.dart';
import 'package:get/instance_manager.dart';

import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => RequestsController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => NotificationsController());
  }
}
