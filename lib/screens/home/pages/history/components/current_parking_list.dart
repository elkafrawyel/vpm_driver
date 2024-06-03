import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/current_parking_controller.dart';
import 'package:driver/screens/home/pages/history/components/current_parking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../widgets/api_state_views/handel_api_state.dart';
import '../../../../../widgets/api_state_views/pagination_view.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class CurrentParkingList extends StatefulWidget {
  const CurrentParkingList({super.key});

  @override
  State<CurrentParkingList> createState() => _CurrentParkingListState();
}

class _CurrentParkingListState extends State<CurrentParkingList>
    with AutomaticKeepAliveClientMixin {
  final CurrentParkingController currentParingController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CurrentParkingController>(
      builder: (_) {
        return HandleApiState.operation(
          operationReply: currentParingController.operationReply,
          shimmerLoader: const Center(
            child: CircularProgressIndicator(),
          ),
          emptyView: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 200,
                  color: Colors.black54,
                ),
                20.ph,
                AppText(
                  'empty_requests'.tr,
                  fontSize: 16,
                ),
                40.ph,
                ElevatedButton(
                  onPressed: () {
                    currentParingController.refreshApiCall();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: AppText(
                      'refresh'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaginationView(
              loadMoreData: currentParingController.callMoreData,
              showLoadMoreWidget: currentParingController.loadingMore,
              showLoadMoreEndWidget: currentParingController.loadingMoreEnd,
              child: RefreshIndicator(
                color: const Color(0xff3D6AA5),
                backgroundColor: Colors.white,
                onRefresh: currentParingController.refreshApiCall,
                child: ListView.builder(
                  itemBuilder: (context, index) => ActiveHistoryCard(
                    parkingModel: currentParingController.paginationList[index],
                  ),
                  itemCount: currentParingController.paginationList.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
