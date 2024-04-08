import 'package:driver/controller/home_screen/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_color.dart';
import '../../../../app/types/booking_tabs_type.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(builder: (_) {
      return DefaultTabController(
        length: historyController.pages.length,
        initialIndex: historyController.selectedIndex,
        child: Scaffold(
          appBar: AppBar(
            title: Text('history'.tr),
            bottom: TabBar(
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: hintColor,
                      ),
              onTap: (int index) {
                if (index == historyController.selectedIndex) {
                  return;
                }
                historyController.selectedIndex = index;
              },
              tabs: BookingTabsType.values
                  .map(
                    (e) => Tab(
                      text: e.title,
                    ),
                  )
                  .toList(),
            ),
          ),
          body: historyController.pages[historyController.selectedIndex],
        ),
      );
    });
  }
}
