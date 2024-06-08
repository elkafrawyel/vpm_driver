import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/current_parking_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../app/config/app_color.dart';
import '../../../../../app/res/res.dart';
import '../../../../../app/util/information_viewer.dart';
import '../../../../../app/util/operation_reply.dart';
import '../../../../../data/models/general_response.dart';
import '../../../../../data/models/parking_model.dart';
import '../../../../../data/providers/network/api_provider.dart';
import '../../../../../widgets/app_widgets/app_cached_image.dart';
import '../../../../../widgets/app_widgets/app_progress_button.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../../../../map_screen/map_screen.dart';

class ActiveHistoryCard extends StatelessWidget {
  final ParkingModel parkingModel;

  const ActiveHistoryCard({
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
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                DateFormat(
                  DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                  Get.locale!.languageCode,
                ).format(
                  DateTime.parse(parkingModel.startsAt!),
                ),
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: hintColor,
              ),
            ),
          ),
          if (parkingModel.startConfirmedAt != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (parkingModel.endDriver == null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.map,
                            color: Colors.green,
                          ),
                          10.pw,
                          AppText(
                            'car_parked'.tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    if ((parkingModel.hasRequestEnd ?? false) && parkingModel.endDriver != null)
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => MapScreen(
                              userModel: parkingModel.user!,
                              parkingId: parkingModel.id!,
                              latitude: parkingModel.endLatitude!,
                              longitude: parkingModel.endLongitude!,
                            ),
                          );
                        },
                        child: AppText(
                          'show_on_map'.tr,
                        ),
                      )
                  ],
                ),
              ),
            ),
          // if ((parkingModel.hasRequestEnd ?? false) &&
          //     parkingModel.endsAt == null)
          //   Center(
          //     child: AppProgressButton(
          //       text: 'end_park'.tr,
          //       fontSize: 14,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       onPressed: _endRequest,
          //     ),
          //   ),
          if (parkingModel.startConfirmedAt == null && parkingModel.endsAt == null)
            Center(
              child: AppProgressButton(
                text: 'park_car'.tr,
                fontSize: 14,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: _parkCar,
              ),
            ),
          10.ph,
        ],
      ),
    );
  }

  Future _parkCar(AnimationController animationController) async {
    animationController.forward();
    Position position = await Get.find<CurrentParkingController>().getMyPosition(loading: true);

    OperationReply operationReply = await APIProvider.instance.patch(
      endPoint: "${Res.apiParkCar}/${parkingModel.id}",
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    );

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.find<CurrentParkingController>().refreshApiCall();
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
