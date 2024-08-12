import 'package:driver/app/config/app_color.dart';
import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/res/res.dart';
import 'package:driver/app/util/information_viewer.dart';
import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/app/util/util.dart';
import 'package:driver/controller/home_screen/current_parking_controller.dart';
import 'package:driver/controller/home_screen/requests_controller.dart';
import 'package:driver/data/models/general_response.dart';
import 'package:driver/data/models/requests_response.dart';
import 'package:driver/data/providers/network/api_provider.dart';
import 'package:driver/screens/map_screen/map_screen.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_progress_button.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:driver/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:driver/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class RequestsCard extends StatelessWidget {
  final RequestModel requestModel;

  const RequestsCard({
    super.key,
    required this.requestModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8.0),
      elevation: 1.0,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            leading: AppCachedImage(
              imageUrl: requestModel.user?.avatar?.filePath,
              isCircular: true,
              width: 80,
              height: 80,
              borderColor: Colors.black,
            ),
            title: AppText(
              requestModel.user?.name ?? '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppText(
                requestModel.user?.phone ?? '',
                color: hintColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Utils.callPhoneNumber(phoneNumber: requestModel.user?.phone ?? '');
              },
              icon: Icon(
                Icons.call,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  requestModel.status?.name ?? '',
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    DateFormat(
                      DateFormat.HOUR_MINUTE_TZ,
                      Get.locale!.languageCode,
                    ).format(
                      DateTime.parse(requestModel.createdAt!),
                    ),
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: hintColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AppText(
              requestModel.type?.name ?? '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: AppProgressButton(
                      text: 'accept_request'.tr,
                      fontSize: 14,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed: _acceptRequest,
                    ),
                  ),
                ),
                12.pw,
                Expanded(
                  child: Center(
                    child: AppProgressButton(
                      text: 'refuse_request'.tr,
                      fontSize: 14,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      onPressed: (animationController) => _refuseRequest(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }

  Future _acceptRequest(AnimationController animationController) async {
    animationController.forward();

    OperationReply operationReply = await APIProvider.instance.patch(
      endPoint: "${Res.apiAcceptRequest}/${requestModel.id}",
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.find<RequestsController>().refreshApiCall();
      if (requestModel.type?.code == 1) {
        Get.find<CurrentParkingController>().refreshApiCall();
        Get.to(
          () => MapScreen(
            userModel: requestModel.user!,
            parkingId: requestModel.parkingId!,
            latitude: requestModel.userLatitude!,
            longitude: requestModel.userLongitude!,
          ),
        );
      }
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  Future _refuseRequest(
    BuildContext context,
  ) async {
    showAppModalBottomSheet(
      context: context,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        final TextEditingController reasonController = TextEditingController();

        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                AppTextFormField(
                  controller: reasonController,
                  hintText: 'refuse_reason'.tr,
                  maxLines: 5,
                  horizontalPadding: 12,
                ),
                Center(
                  child: AppProgressButton(
                    text: 'refuse_request'.tr,
                    backgroundColor: Colors.red,
                    onPressed: (animationController) async {
                      animationController.forward();

                      OperationReply operationReply = await APIProvider.instance.patch(
                        endPoint: "${Res.apiRefuseRequest}/${requestModel.id}",
                        fromJson: GeneralResponse.fromJson,
                        requestBody: {
                          'reasone': reasonController.text,
                        },
                      );

                      if (operationReply.isSuccess()) {
                        GeneralResponse generalResponse = operationReply.result;
                        InformationViewer.showSuccessToast(msg: generalResponse.message);
                        animationController.reverse();
                        await Future.delayed(const Duration(milliseconds: 100));

                        Get.find<RequestsController>().refreshApiCall();
                      } else {
                        InformationViewer.showErrorToast(msg: operationReply.message);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
