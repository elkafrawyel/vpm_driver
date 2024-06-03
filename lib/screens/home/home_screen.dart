import 'package:driver/app/config/app_color.dart';
import 'package:driver/controller/home_screen/home_screen_controller.dart';
import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with FCMNotificationMixin, FCMNotificationClickMixin {
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (_) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeScreenController.selectedTabIndex!,
          onTap: homeScreenController.handleIndexChanged,
          iconSize: 25,
          selectedItemColor: Colors.black,
          unselectedItemColor: hintColor,
          type: BottomNavigationBarType.fixed,
          items: [
            // BottomNavigationBarItem(
            //   icon: const Icon(Icons.home_outlined, color: hintColor),
            //   activeIcon: const Icon(Icons.home_outlined, color: Colors.black),
            //   label: 'home'.tr,
            // ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_actions_rounded, color: hintColor),
              activeIcon: const Icon(
                Icons.pending_actions_rounded,
                color: Colors.black,
              ),
              label: 'requests'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history, color: hintColor),
              activeIcon: const Icon(Icons.history, color: Colors.black),
              label: 'history'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add, color: hintColor),
              activeIcon: const Icon(Icons.add, color: Colors.black),
              label: 'add'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications, color: hintColor),
              activeIcon: const Icon(Icons.notifications, color: Colors.black),
              label: 'notifications'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu, color: hintColor),
              activeIcon: const Icon(Icons.menu, color: Colors.black),
              label: 'menu'.tr,
            ),
          ],
        ),
        body: PageView(
          controller: homeScreenController.pageController,
          // ==>> stop Swipe
          // physics: NeverScrollableScrollPhysics(),
          children: homeScreenController.pages,
          onPageChanged: (selectedPageIndex) {
            homeScreenController.handleIndexChanged(selectedPageIndex);
          },
        ),
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    if (kDebugMode) {
      print(
          'Notification Model====>\n${notification.data['notification_model']}');
    }

    Get.find<NotificationsController>().addNewNotification(notification);
    homeScreenController.handleNotificationClick(
      notification,
      withNavigation: false,
    );
  }

  @override
  void onClick(RemoteMessage notification) {
    homeScreenController.handleNotificationClick(notification);
  }
}
