import 'package:driver/app/config/app_color.dart';
import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCard({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              notificationModel.name!,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  DateFormat(DateFormat.HOUR_MINUTE).format(
                    DateTime.parse(notificationModel.dateTime!),
                  ),
                  fontSize: 14,
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
