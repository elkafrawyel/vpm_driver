import 'package:driver/screens/home/pages/add_valet/add_valet_screen.dart';
import 'package:driver/screens/home/pages/history/history_screen.dart';
import 'package:driver/screens/home/pages/menu/menu_screen.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/util/util.dart';
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
      const HistoryScreen(),
      const AddValetScreen(),
      const NotificationsScreen(),
      const MenuScreen(),
    ];
    initializeNotifications();
  }

  Future initializeNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FCMConfig.instance.init(
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'com.vpm.diver',
        'Driver',
      ),
    );

    FCMConfig.instance.messaging.getToken().then((token) {
      Utils.logMessage('Firebase Token:$token');
    });
  }

  handleIndexChanged(int index) {
    selectedTabIndex = index;
    pageController.jumpToPage(index);
    update();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
  // Get.find<HomeScreenController>().handleRemoteMessage(message);
}
