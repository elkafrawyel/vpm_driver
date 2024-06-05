import 'package:driver/data/models/parking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

import '../../../../../app/config/app_color.dart';
import '../../../../../widgets/app_widgets/app_cached_image.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class EndedParkingCard extends StatelessWidget {
  final ParkingModel parkingModel;

  const EndedParkingCard({
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
                ).add_jmv().format(
                      DateTime.parse(parkingModel.startsAt!),
                    ),
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
