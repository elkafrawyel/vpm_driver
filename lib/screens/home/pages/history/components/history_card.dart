import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/history_controller.dart';
import 'package:driver/data/models/parking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

import '../../../../../app/config/app_color.dart';
import '../../../../../app/res/res.dart';
import '../../../../../app/util/information_viewer.dart';
import '../../../../../app/util/operation_reply.dart';
import '../../../../../data/models/general_response.dart';
import '../../../../../data/providers/network/api_provider.dart';
import '../../../../../widgets/app_widgets/app_cached_image.dart';
import '../../../../../widgets/app_widgets/app_progress_button.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class HistoryCard extends StatelessWidget {
  final ParkingModel parkingModel;

  const HistoryCard({
    super.key,
    required this.parkingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            leading: AppCachedImage(
              imageUrl: parkingModel.user?.avatar?.filePath,
              isCircular: true,
              width: 80,
              height: 80,
              borderColor: Colors.black,
            ),
            title: AppText(
              parkingModel.user?.name ?? '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: hintColor,
                    size: 20,
                  ),
                  AppText(
                    parkingModel.user?.phone ?? '',
                    color: hintColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          if (parkingModel.endsAt == null)
            Center(
              child: AppProgressButton(
                text: 'end_park'.tr,
                fontSize: 14,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                onPressed: _endRequest,
              ),
            ),
          20.ph,
        ],
      ),
    );
  }

  Future _endRequest(AnimationController animationController) async {
    animationController.forward();

    OperationReply operationReply = await APIProvider.instance.patch(
      endPoint: "${Res.apiEndParking}/${parkingModel.id}",
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.find<HistoryController>().refreshApiCall();
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
