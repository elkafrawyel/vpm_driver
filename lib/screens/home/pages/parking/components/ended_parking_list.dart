import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/ended_parking_controller.dart';
import 'package:driver/widgets/api_state_views/pagination_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../widgets/api_state_views/handel_api_state.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import 'ended_parking_card.dart';

class EndedParkingList extends StatefulWidget {
  const EndedParkingList({super.key});

  @override
  State<EndedParkingList> createState() => _EndedParkingListState();
}

class _EndedParkingListState extends State<EndedParkingList>
    with AutomaticKeepAliveClientMixin {
  // to keep the controller instance on memory
  final EndedParkingController endedParkingController = Get.find();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<EndedParkingController>(
      builder: (_) {
        return HandleApiState.operation(
          operationReply: endedParkingController.operationReply,
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
                  color: Colors.black45,
                ),
                20.ph,
                AppText(
                  'empty_requests'.tr,
                  fontSize: 16,
                ),
                40.ph,
                ElevatedButton(
                  onPressed: () {
                    endedParkingController.refreshApiCall();
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
                )
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PaginationView(
              loadMoreData: endedParkingController.callMoreData,
              showLoadMoreWidget: endedParkingController.loadingMore,
              showLoadMoreEndWidget: endedParkingController.loadingMoreEnd,
              child: RefreshIndicator(
                color: const Color(0xff3D6AA5),
                backgroundColor: Colors.white,
                onRefresh: endedParkingController.refreshApiCall,
                child: ListView.builder(
                  itemBuilder: (context, index) => EndedParkingCard(
                    parkingModel: endedParkingController.paginationList[index],
                  ),
                  itemCount: endedParkingController.paginationList.length,
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
