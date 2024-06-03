import 'package:driver/controller/pagination_controller/pagination_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/res/res.dart';
import '../../data/models/parking_model.dart';
import '../../widgets/dialogs_view/app_dialog_view.dart';

class CurrentParkingController extends PaginationController<ParkingModel> {
  CurrentParkingController(super.configData);

  Future checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _openSettingDialog();
        Future.error('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _openSettingDialog();
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }

  Future<Position> getMyPosition({bool loading = true}) async {
    await checkLocationPermission();
    if (loading) {
      EasyLoading.show(status: 'getting_location'.tr);
    }
    Position myLocation = await Geolocator.getCurrentPosition();
    if (loading) {
      EasyLoading.dismiss();
    }
    return myLocation;
  }

  _openSettingDialog() {
    Get.dialog(
      AppDialogView(
        title: 'location_permission'.tr,
        message: 'location_permission_message'.tr,
        onActionClicked: () async {
          Get.back();
          openAppSettings();
        },
        actionText: 'ok'.tr,
        svgName: Res.iconLocation,
      ),
    );
  }
}
