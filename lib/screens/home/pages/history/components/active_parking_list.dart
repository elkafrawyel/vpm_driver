import 'package:driver/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/state_manager.dart';

import '../../../../../controller/home_screen/history_controller.dart';
import '../../../../../widgets/api_state_views/handel_api_state.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import 'history_card.dart';

class ActiveParkingList extends StatelessWidget {
  const ActiveParkingList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      builder: (historyController) {
        return HandleApiState.operation(
          operationReply: historyController.operationReply,
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
                    historyController.refreshApiCall();
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
            child: ListView.builder(
              itemBuilder: (context, index) => HistoryCard(
                parkingModel: historyController.currentParkingList[index],
              ),
              itemCount: historyController.currentParkingList.length,
            ),
          ),
        );
      },
    );
  }
}
