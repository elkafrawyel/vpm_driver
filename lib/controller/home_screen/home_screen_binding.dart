import 'package:driver/controller/home_screen/current_parking_controller.dart';
import 'package:driver/controller/home_screen/ended_parking_controller.dart';
import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:driver/controller/home_screen/requests_controller.dart';
import 'package:driver/controller/pagination_controller/data/config_data.dart';
import 'package:get/instance_manager.dart';

import '../../app/res/res.dart';
import '../../data/models/notifications_model.dart';
import '../../data/models/parking_model.dart';
import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => RequestsController());

    Get.lazyPut(
      () => CurrentParkingController(
        ConfigData(
          apiEndPoint: Res.apiGetParkingList,
          fromJson: ParkingModel.fromJson,
          parameters: {
            'status': 'current',
          },
        ),
      ),
    );

    Get.lazyPut(
      () => EndedParkingController(
        ConfigData(
          apiEndPoint: Res.apiGetParkingList,
          fromJson: ParkingModel.fromJson,
          parameters: {
            'status': 'ended',
          },
        ),
      ),
    );

    Get.lazyPut(
      () => NotificationsController(
        ConfigData(
          apiEndPoint: Res.apiNotifications,
          fromJson: NotificationsModel.fromJson,
        ),
      ),
    );
  }
}
