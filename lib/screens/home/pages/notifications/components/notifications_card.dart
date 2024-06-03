import 'package:driver/app/config/app_color.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/notifications_model.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationsModel notificationsModel;

  const NotificationsCard({super.key, required this.notificationsModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              Get.locale?.languageCode == "ar"
                  ? notificationsModel.eventNameAr ?? ''
                  : notificationsModel.eventName ?? '',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                Get.locale?.languageCode == "ar"
                    ? notificationsModel.eventContentAr ?? ''
                    : notificationsModel.eventContent ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: hintColor,
                maxLines: 3,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  DateFormat(
                    "hh:mm a",
                    Get.locale?.languageCode,
                  ).format(
                    DateTime.parse(notificationsModel.createdAt!),
                  ),
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                  color: hintColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
