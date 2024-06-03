import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_color.dart';
import '../../../../app/types/booking_tabs_type.dart';
import 'components/current_parking_list.dart';
import 'components/ended_parking_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  List<Widget> pages = [
    const CurrentParkingList(),
    const EndedParkingList(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: pages.length,
      initialIndex: selectedIndex,
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
              if (index == selectedIndex) {
                return;
              }
              setState(() {
                selectedIndex = index;
              });
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
        body: pages[selectedIndex],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
