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
            trailing: Offstage(
              offstage: requestModel.status?.code == 2,
              child: IconButton(
                onPressed: () {
                  Utils.callPhoneNumber(phoneNumber: requestModel.user?.phone ?? '');
                },
                icon: Icon(
                  Icons.call,
                  color: Theme.of(context).primaryColor,
                ),
              ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  requestModel.status?.name ?? '',
                  color: requestModel.status?.code == 2 ? Colors.red : Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        DateFormat(
                          DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                          Get.locale!.languageCode,
                        ).format(
                          DateTime.parse(requestModel.createdAt!),
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: hintColor,
                      ),
                      AppText(
                        DateFormat(
                          DateFormat.HOUR_MINUTE_SECOND,
                          Get.locale!.languageCode,
                        ).format(
                          DateTime.parse(requestModel.createdAt!),
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: hintColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (requestModel.status?.code == 0)
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
                if (requestModel.status?.code == 1 && requestModel.parkingId == null)
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
          if (requestModel.reason != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText(
                'refuse_reason'.tr,
                color: hintColor,
              ),
            ),
          if (requestModel.reason != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 12, bottom: 28, start: 18),
              child: AppText(
                requestModel.reason ?? '',
                maxLines: 5,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
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
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        final TextEditingController reasonController = TextEditingController();

        return Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'refuse_reason'.tr,
                    ),
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
                            Get.back();
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
            ),
          ),
        );
      },
    );
  }
}
