import 'dart:convert';

import 'package:driver/controller/home_screen/current_parking_controller.dart';
import 'package:driver/controller/home_screen/requests_controller.dart';
import 'package:driver/screens/home/pages/add_valet/add_valet_screen.dart';
import 'package:driver/screens/home/pages/menu/menu_screen.dart';
import 'package:driver/screens/home/pages/parking/parking_screen.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/util/util.dart';
import '../../data/models/notifications_model.dart';
import '../../firebase_options.dart';
import '../../screens/home/pages/notifications/notifications_screen.dart';
import '../../screens/home/pages/requests/requets_screen.dart';

class HomeScreenController extends GetxController {
  int? selectedTabIndex;
  late List<Widget> pages;

  late PageController pageController;

  @override
  void onInit() async {
    super.onInit();
    selectedTabIndex = 0;
    pageController = PageController(initialPage: 0);
    pages = [
      const RequestsScreen(),
      const ParkingScreen(),
      const AddValetScreen(),
      const NotificationsScreen(),
      const MenuScreen(),
    ];
  }

  handleIndexChanged(int index) {
    selectedTabIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void handleNotificationClick(
    RemoteMessage notification, {
    bool withNavigation = true,
  }) {
    NotificationsModel notificationsModel = NotificationsModel.fromJson(
      jsonDecode(
        notification.data['notification_model'].toString(),
      ),
    );

    switch (notificationsModel.moduleCode) {
      case 1:
        switch (notificationsModel.eventCode) {
          case 1:

            ///تم ارسال طلب سائق
            ///REQUEST_START_PARKING
            Get.find<RequestsController>().refreshApiCall();
            break;
            case 4:

            ///تم ارسال طلب إنهاء ركنة
            ///REQUEST_END_PARKING
            Get.find<RequestsController>().refreshApiCall();
            break;
        }
        break;

      case 2:
        break;
    }
  }
}
